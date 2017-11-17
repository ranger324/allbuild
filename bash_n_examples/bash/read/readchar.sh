B=
while read -r -s -N 1 k # Read one key (first byte in key press)
do
#printf "%c" "$k"
#[ -z "$(printf "%c" "$k")" ] && echo ENTER
#xxd -p -r
#echo -n "$k" | od
#echo -n "A" | od -An -tuC
#printf \\$(printf "%03o" "65")
#printf "%d" "'$k"
#if [ "$(echo -n "$k" | hexdump -ve '1/1 "%.2X"')" != "0A" ]; then
#    echo -n "$k" | hexdump -ve '1/1 "%.2X"'
#    echo
#    printf "%d\n" "'$k"
#    echo "$k"
#else
#    echo -n "$k" | hexdump -ve '1/1 "%.2X"'
#    echo
#    printf "%d\n" "'$k"
#fi
    case "$k" in
    [[:graph:]])
#[ "$k" == "a" ] && echo -n a && B="${B}a"
        [ "$k" == "q" ] && break
        # Normal input handling
        ;;
    $'\x09') # TAB
        # Routine for selecting current item
        ;;
    $'\x7f')
        printf "\b \b"
        # Back-Space
        # Routine for back-space
        ;;
    $'\x01') # Ctrl+A
        # Routine for ctrl+a
        ;;
    $'\x1b') # ESC
        read -r -s -N 1 k
        [ "$k" == "" ] && return    # Esc-Key
        [ "$k" == "[" ] && read -r -s -N 1 k
        [ "$k" == "O" ] && read -r -s -N 1 k
#printf "%c\n" "$k"
        case "$k" in
        A) echo up
           # Up
           # Routine for handling arrow-up-key
            ;;
        B) echo down
           # Down
           # Routine for handling arrow-down-key
            ;;
        esac
        read -r -s -N 4 -t .1 # Try to flush out other sequences ...
    esac
done
echo
echo "$B"
