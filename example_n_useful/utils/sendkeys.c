/* AGK 14/2/1998.
   Routine to simulate a line of terminal input
   based on code found lying around from 1992. */

#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

extern int errno;

int main(int argc, char *argv[])
{
  int f;
  char *c;

  if (argc != 3)
  {
    fprintf(stderr, "Usage: %s /dev/tty?? 'chars|\\n'\n", argv[0]);
    exit(1);
  }
  if ((f = open(argv[1], O_RDWR)) == -1) /* Open tty */
  {
        perror("open");
        exit(errno);
  }


  if (argv[2][0] == '\\' && argv[2][1] == 'n')
  {
    if (ioctl(f, TIOCSTI, "\n") == -1)
    {
      perror("ioctl");
      exit(errno);
    }
    exit(0);
  }

  for (c = argv[2]; *c; c++) /* Process argument one character at a time */
    if (ioctl(f, TIOCSTI, c) == -1) /* Insert char into tty input buffer */
    {
      perror("ioctl");
      exit(errno);
    }

  exit(0);
}
