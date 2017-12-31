#nm -n bash #all in executable
#nm -u bash #undefined
#nm -D bash #dynamic
#nm -a bash #all include debug
#nm --defined-only libao.so.4.1.0
#nm --defined-only -D libao.so.4.1.0
#nm -u libao.so.4.1.0 #undefined
find -type f -name "*.so*" | while read file; do echo "$file"; nm -u $file; done
