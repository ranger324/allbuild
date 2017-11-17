 while getopts ae:f:hd:s:qx: option
 do
         case "${option}"
         in
                 a) ALARM="TRUE";;
                 e) ADMIN=${OPTARG};;
                 d) DOMAIN=${OPTARG};;
                 f) SERVERFILE=$OPTARG;;
                 s) WHOIS_SERVER=$OPTARG;;
                 q) QUIET="TRUE";;
                 x) WARNDAYS=$OPTARG;;
                 \?) usage
                     exit 1;;
         esac
 done

echo "$@"
echo "$OPTIND"

aasd()
{
echo "$0"
echo "$1"
}
aasd
shift $(( $OPTIND - 1 ))

echo "$@"
