#nocasematch

A="text.deps"
if [[ "$A" =~ ^text* ]]; then
echo $A
fi
if [[ "compressed.gssss" =~ ^(.*)(\.[a-z]{1,5})$ ]];
then
echo "${BASH_REMATCH[1]}"
echo "${BASH_REMATCH[2]}"
else
echo "Not proper format"
fi

if [[ "compressed.gssss" =~ ^(.*)(\.[a-z]{1,})$ ]];
then
echo "${BASH_REMATCH[1]}"
echo "${BASH_REMATCH[2]}"
else
echo "Not proper format"
fi


if [[ "compressed.gz" =~ ^(.*)(\.[a-z]{2})$ ]];
then
echo "${BASH_REMATCH[1]}"
echo "${BASH_REMATCH[2]}"
else
echo "Not proper format"
fi

if [[ "compressed.gz" =~ ^(.*)(\.gz)$ ]];
then
echo "${BASH_REMATCH[1]}"
echo "${BASH_REMATCH[2]}"
else
echo "Not proper format"
fi

A="text.deps"
if [[ "$A" =~ t\.d ]]; then
echo "$A"
echo "${BASH_REMATCH[0]}"
fi

A="text deps"
if [[ "$A" =~ t\ d ]]; then
echo "$A"
echo "${BASH_REMATCH[0]}"
fi

A="text deps"
if [[ "$A" =~ t[\ ]d ]]; then
echo "$A"
echo "${BASH_REMATCH[0]}"
fi

A="text deps"
if [[ "$A" =~ \ d ]]; then
echo "$A"
echo "${BASH_REMATCH[0]}"
fi
