[ -z "$1" ] && echo "Add username as parameter" && exit 1
openvt -c 8 -s -- sudo -u $1 -- screen sh -c 'cd; exec bash -l'
