import sys, fcntl, termios, os

if __name__ == '__main__':
    if len(sys.argv) != 3:
	print 'Usage: ' + sys.argv[0] + ' /dev/tty?? "chars|\\n"'
	sys.exit(1)

    try:
	tty = open(sys.argv[1])
    except:
	sys.exit(1)

    if sys.argv[2][0] == "\\" and sys.argv[2][1] == "n":
	fcntl.ioctl(tty, termios.TIOCSTI, "\n")
    else:
	for x in sys.argv[2]:
	    fcntl.ioctl(tty, termios.TIOCSTI, x)

    tty.close()
