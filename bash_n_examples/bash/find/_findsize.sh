find -name "*.zip" | xargs -i sh -c "echo -n '{} '; stat -c %s '{}'" | sort -n -k 2 -r
