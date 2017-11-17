exec 4>&1
#exitstatus=`((ls /sys /nib 3>&-; printf $? 1>&3) 4>&- | sed 's%class%*class*%' >&4) 3>&1`
#exitstatus=`((ls /sys /nib 2>&-; printf $? 1>&3) 4>&- | sed 's%class%*class*%' >&4) 3>&1`
exitstatus=`((ls /sys /nib 2>&-; printf $? 1>&3) | sed 's%class%*class*%' >&4) 3>&1`
echo $exitstatus
exec 4>&-
