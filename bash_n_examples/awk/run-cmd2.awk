#! /usr/bin/awk -f

BEGIN{
    cmd = "echo -ne 'a\nb\n' | grep 'a'"
    cmd | getline lines
    close(cmd)
    printf "output: " lines "\n"
}
