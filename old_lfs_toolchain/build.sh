for i in 033 033_ 033__ 034; do
    PTH=`find -mindepth 2 -maxdepth 2 -type f -name "$i"`
    cd `dirname $PTH`
    sh `basename $PTH`
    cd ..
done
