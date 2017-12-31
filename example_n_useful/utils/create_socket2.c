#define _FILE_OFFSET_BITS 64
#include <string.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/un.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char **argv)
{
    // The following line expects the socket path to be first argument
    char * mysocketpath = argv[1];
    // Alternatively, you could comment that and set it statically:
    //char * mysocketpath = "/tmp/mysock";
    struct sockaddr_un namesock;
    int fd;

    if (argc == 1) {
        fprintf(stderr, "usage: create_socket socket\n");
        exit(1);
    }

    namesock.sun_family = AF_UNIX;
    strncpy(namesock.sun_path, (char *)mysocketpath, sizeof(namesock.sun_path));
    fd = socket(AF_UNIX, SOCK_DGRAM, 0);
    bind(fd, (struct sockaddr *) &namesock, sizeof(struct sockaddr_un));
    close(fd);
    return 0;
}
