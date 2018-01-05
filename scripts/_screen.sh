[ -z "$1" ] && echo "Add user" && exit 1
openvt -c 8 -s -- sudo -u $1 -- screen sh -c 'cd; exec bash -l'
