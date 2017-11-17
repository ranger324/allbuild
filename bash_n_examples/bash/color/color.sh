         var="\033[36;1mDISK\033[0m"                                                    
         newvar=$(printf ${var} | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g") 
         echo ${newvar}                                                                 
printf "$var\n"
