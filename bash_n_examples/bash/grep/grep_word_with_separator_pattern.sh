T=$'\t'
spt="[${T} ,\]\+"
for i in */*.mk; do NAME=$(dirname "$i"); grep -q "^host-${NAME}${spt}\|${spt}host-${NAME}${spt}\|${spt}host-${NAME}$\|^host-${NAME}$" $i && echo "$i"; done
#for i in */*.mk; do NAME=$(dirname "$i"); grep -q "host-${NAME}" $i && echo $i ; done

T=$'\x09'
T=$'\t'
spt="[${T} ,\]\+"
#spt="[$'\t' ,\]\+"
#spt="[	 ,\]\+"
#spt='[	 ,\]\+'
#for i in */*.mk; do NAME=$(dirname "$i"); grep -q "^host-${NAME}${spt}\|${spt}host-${NAME}${spt}\|${spt}host-${NAME}$\|^host-${NAME}$" $i && echo "$i"; done
#for i in */*.mk; do NAME=$(dirname "$i"); grep -q "host-${NAME}" $i && echo $i ; done

spt2='[\t ,\\]+'
#spt2="[\t ,\\\]+"
for i in */*.mk; do NAME=$(dirname "$i"); grep -qP "^host-${NAME}${spt2}|${spt2}host-${NAME}${spt2}|${spt2}host-${NAME}$|^host-${NAME}$" $i && echo "$i"; done
