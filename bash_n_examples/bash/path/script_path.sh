DIR=`dirname "$0"`
#echo "$DIR"
readlink /proc/$$/root
OPWD=`pwd`
#bash
#pushd . > /dev/null
cd "$DIR"
SCRIPTPATH=`pwd -P`
SCRIPT=`basename "$0"`
echo "$SCRIPTPATH/$SCRIPT"
#bash
#popd > /dev/null
cd "$OPWD"
