sed -i -e '/^	bool.*/d' \
-e '/^	#.*/d' \
-e '/^	depends.*/d' \
-e '/^	select.*/d' \
-e '/^	help$/d' \
desc2
