which()
{
	local aflag sflag ES a opt

	OPTIND=1
	while builtin getopts as opt ; do
		case "$opt" in
		a)	aflag=-a ;;
		s)	sflag=1 ;;
		?)	echo "which: usage: which [-as] command [command ...]" >&2
			exit 2 ;;
		esac
	done

	(( $OPTIND > 1 )) && shift $(( $OPTIND - 1 ))

	# without command arguments, exit with status 1
	ES=1

	# exit status is 0 if all commands are found, 1 if any are not found
	for command; do
		# if $command is a function, make sure we add -a so type
		# will look in $PATH after finding the function
		a=$aflag
		case "$(builtin type -t $command)" in
		"function")	a=-a;;
		esac

		if [ -n "$sflag" ]; then
			builtin type -p $a $command >/dev/null 2>&1
		else
			builtin type -p $a $command
		fi
		ES=$?
	done

	return $ES
}
which ls
which a


verbose=
while getopts :q OPT; do
    case "${OPT}" in
    q)  verbose=-q;;
    \?) printf "unknown option '%s'\n" "${OPTARG}" >&2; exit 1;;
    esac
done
shift $((OPTIND-1))
output="${1}"
url="${2}"
shift 2 # Get rid of our options
echo $output
echo $url

while getopts a:cfhj:o:qs? arg
do
    case $arg in
        a ) ARCHES=$OPTARG ;;
        c ) CCACHE=1 ;;
        j ) PARALLEL="-j$OPTARG" ;;
        f ) FETCH=1 ;;
        o ) OUTDIR=$OPTARG ;;
        q ) QUIET=1 ;;
        s ) STRIP=1 ;;
        h ) help ;;
        ? ) help ;;
        * ) echo "unrecognized option '$arg'" ; exit 1 ;;
    esac
done
