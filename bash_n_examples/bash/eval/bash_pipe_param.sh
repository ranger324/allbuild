
asd()
{
    echo 'asd' | eval $1
}

asd "grep -o 'a.' | sed 's/a/#/'"
