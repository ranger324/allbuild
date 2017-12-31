[ -d /run/media/$(whoami) ] && cd /run/media/$(whoami) || cd /media
find -maxdepth 1 -mindepth 1 -type d -print0 | xargs -r -0 -i umount {}
