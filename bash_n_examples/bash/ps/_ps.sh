#ps axco pid,ppid,command,args
#ps -axeo pid,ppid,command
#ps axo pid,ppid,command | grep "^ *[0-9]\+ \+[0-9]\+ [^[]"
#ps o pid,ppid,command --ppid 2 -p 2 --deselect
ps fo ppid,pid,pgid,sid,tty,tpgid,stat,uid,time,command --ppid 2 -p 2 --deselect
#ps o ppid,pid,pgid,sid,tty,tpgid,stat,uid,time,command --ppid 2 -p 2 --deselect
