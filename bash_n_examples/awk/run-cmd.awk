#! /usr/bin/awk -f

BEGIN{
    cmd = "date"
    cmd | getline mydate
    close(cmd)
    printf "output: " mydate "\n"
}
