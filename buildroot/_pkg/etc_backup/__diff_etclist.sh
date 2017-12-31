#
sh _etcfiles.sh > /tmp/etcfiles.lst
diff --new-line-format="+%L" --old-line-format="-%L" \
    --unchanged-line-format="&%L" /var/lib/instpkg/etcfiles.lst /tmp/etcfiles.lst | grep "^+"
