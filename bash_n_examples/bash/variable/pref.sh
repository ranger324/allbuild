A="123\n"
A=${A/%/321\\n}
echo -ne "$A"
#suffix
#${ARCHIVE/%/asd}
#prefix
#${ARCHIVE/#/asd}
A="@123@321@abc@cba@"

[[ "$A" =~ \#321\# ]] && echo match
[[ "$A" =~ @321@ ]] && echo match
[[ "$A" =~ "@321@" ]] && echo match
A=${A//@/\\n}
echo -ne "$A"
echo -ne "*$A*\n"
