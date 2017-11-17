
echo "  \$(ASD )" | grep "^[[:space:]]\+\$(" | grep -qv "^[[:space:]]\+\$([A-Z0-9_]\+)" && echo true || echo false
echo "  \$(ASD_1)" | grep "^[[:space:]]\+\$(" | grep -qv "^[[:space:]]\+\$([A-Z0-9_]\+)" && echo true || echo false
