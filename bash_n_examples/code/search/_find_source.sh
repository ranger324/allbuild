#file contains pattern && pattern
find -type f -name "*.[c,h]" | xargs -r -i sh -c 'grep -q "resolv.h" {} && grep -q "res_init" {} && echo {}'
