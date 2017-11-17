#VAR2.6.34.9-lt -> VAR2_6_34_9_lt
#ASD: assign value of "variable name charachters"
ASD=1
eval ASD$ASD=2
TMPVAR="ASD$ASD"
eval 'echo $'$TMPVAR
eval echo '$'$TMPVAR
