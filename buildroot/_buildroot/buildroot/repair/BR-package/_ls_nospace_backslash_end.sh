find -mindepth 2 -name "*.mk" | xargs -r grep -n "[^[:space:]][\]$"
