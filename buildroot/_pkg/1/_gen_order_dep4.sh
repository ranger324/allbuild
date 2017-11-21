#set +e


#ls */depends | xargs wc -l | grep -v "^[[:space:]]*[0-9]\+ total" | sort -n | sed 's/^[[:space:]]*//' > _order.tmp

LC_ALL=C cut -d / -f 2 .name_cache2.tmp1.sort | sed 's%.*%&/depends%' | xargs wc -l | \
    grep -v "^[[:space:]]*[0-9]\+ total" | sort -n | sed 's/^[[:space:]]*//' > _order.tmp
#exit 0
while true; do
#break


first=$(head -n 1 _order.tmp)
#NUMOLD=$NUM
NUM=`echo "$first" | cut -d " " -f 1`
#echo "$first" | cut -d ' ' -f 2
NAME=$(echo "$first" | cut -d ' ' -f 2 | cut -d / -f 1 | rev | cut -d - -f 3- | rev)
#[ "$NUMOLD" != "$NUM" ] && change=1 || change=0
#echo $first
#echo $NUM
[ -z "$first" ] && break

if [ `echo "$first" | cut -d " " -f 1` = 0 ]; then
    tail -n +2 _order.tmp >_order.tmp2
    echo "$first" | cut -d ' ' -f 2
    cp -RpP $(echo "$first" | cut -d ' ' -f 2 | cut -d / -f 1) /dest3
    mv _order.tmp2 _order.tmp
else
    deperror=
    #echo $first
    for i in `cat $(echo "$first" | cut -d ' ' -f 2)`; do
#	echo -n "$i"
	##
	#ls_dest=`ls /dest3/* | rev | cut -d - -f 3- | rev`
	#if echo $ls_dest |grep -q "$i"; then
	pkgextname=`grep "^$i " .name_cache2.tmp1.sort | cut -d / -f 2`
	if test -e /dest3/$pkgextname; then
	    :
#	    echo " OK"
	else
#	    echo " NOTOK"
	    deperror=1
############
	    break
	fi
############
	[ "$NAME" = "$i" ] && echo "$i----$i----$i"
    done
    if [ -z "$deperror" ]; then
	tail -n +2 _order.tmp >_order.tmp2
	echo "$first" | cut -d ' ' -f 2
	cp -RpP $(echo "$first" | cut -d ' ' -f 2 | cut -d / -f 1) /dest3
	mv _order.tmp2 _order.tmp
    else
	tail -n +2 _order.tmp >_order.tmp2
	echo "$first" >> _order.tmp2
	mv _order.tmp2 _order.tmp
    fi

fi
#if [ "$change" = 1 ]; then
#sort -n _order.tmp | sed 's/^[[:space:]]*//' >_order.tmp2
#mv  _order.tmp2 _order.tmp
#fi
done
