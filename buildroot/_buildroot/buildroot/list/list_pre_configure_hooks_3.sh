
#line separated
#spaces in line
varpatt_static()
{
varpatt="$@"
local A PP MM val
(echo -n "$varpatt"; echo -n ")") | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
if [ "$PP" = "$MM" ]; then
    if [ "$A" != "-" ]; then
	echo -n "$A"
	val=1
    fi
else
    [ "$A" = "-" ] && [ -n "$val" ] && echo && val=
fi
done
}

varpatt_var()
{
varpatt="$@"
local A PP MM val
echo -n "$varpatt" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
if [ "$PP" = "$MM" ]; then
    if [ -n "$val" ]; then
	echo "-"
	val=
    fi
else
    echo -n "$A"
    val=1
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'
}

pattern1='\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)'
pattern2='\$(\|)\|,'
#pattern2 |$(|  |)|  |,|
procdeps()
{
origstr="$@"
#with $() variable defs
if echo "$origstr" | grep -q "$pattern2"; then
#return from if
	cnum1=`echo -n "$origstr" | sed 's/[^(]//g' | wc -c`
	cnum2=`echo -n "$origstr" | sed 's/[^)]//g' | wc -c`

	#one line $() variable defs
	if [ "$cnum1" = "$cnum2" ]; then

	statdefs=`varpatt_static "$origstr"`
	vardefs=`varpatt_var "$origstr"`

	#variable defs
	IFS1=$IFS
	IFS=$'\n'
	for var in $vardefs; do
	    #if variable def
	    if echo "$var" | grep -q "$pattern1"; then
		VARS=`echo "$var" | sed -e 's/[^,]\+,//' -e 's/)$//'`
		IFS2=$IFS
		IFS=$' ,\t'
		for i in $VARS; do
		    [ -z "$i" ] && continue
#		    echo "->$i"
		    sh _find_file_section.sh -n "$mkfile" "^define[[:space:]]\+$i" "^endef"
		done
		IFS=$IFS2
	    #not if $(if...) var
	    else
#		echo "->$var"
:
	    fi
	done
	IFS=$IFS1

	#static defs
	IFS1=$IFS
	IFS=$'\n'
	for var in $statdefs; do
	    #spaces
	    #var=`echo $var`
	    var="${var//[[:space:]]/}"
#	    echo "->$var"
	    sh _find_file_section.sh -n "$mkfile" "^define[[:space:]]\+$var" "^endef"
	done
	IFS=$IFS1

	#multi line (split) $() variable defline part
	else
#	    echo "->$origstr"
:
	fi
	return 0
fi
#without $() variable
#!simple for with IFS (capital letter vars without space)
for i in $origstr; do
#	echo "->$i"
	sh _find_file_section.sh -n "$mkfile" "^define[[:space:]]\+$i" "^endef"
done
}


omkfile=
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read -r mkfile; do
    grep -n "^.*_PRE_CONFIGURE_HOOKS[[:space:]]\+[+=]" "$mkfile" | \
    while read -r aa decb decc; do
#	[ "$omkfile" != "$mkfile" ] && echo "---$mkfile" && omkfile="$mkfile"
	[ "$omkfile" != "$mkfile" ] && omkfile="$mkfile"
	multiline=
	[ "$decc" != "$(echo "$decc" | sed 's%[\]$%%')" ] && multiline=1 && decc=$(echo "$decc" | sed 's%[\]$%%')
	numline=`echo "$aa" | cut -d : -f 1`
	deca=`echo "$aa" | cut -d : -f 2-`

	if [ -z "$decc" ]; then
#	    echo "<-$deca $decb"
:
	else
#	    echo "<-$deca $decb $decc"
	    procdeps "$decc"
	fi
#	echo
	if [ "$multiline" = "1" ]; then
	    num=0
	    while true; do
		num=`expr $num + 1`
		nextline=$(expr $numline + $num)
		line=`head -n "$nextline" "$mkfile" | tail -n 1`
		line2=`echo "$line" | sed 's%[\]$%%'`
		procdeps "$line2"
#		echo
		[ "$line" = "$line2" ] && break
	    done
	fi
    done
done
#find -name "*.mk" | xargs -r grep "^LINUX_TOOLS[[:space:]]\+[+:=-]\+"
