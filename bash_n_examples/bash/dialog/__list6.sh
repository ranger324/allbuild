
echo -ne "adsa sada\x00asdasd\x00sfa  sada ads \x00dsasda" | xargs -0 dialog --backtitle "Create disklabel" \
	--title "" --clear \
	--menu "" 20 61 15
