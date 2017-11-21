#find -mindepth 2 -type f -name "*.mk" | xargs -r grep -nPo '(?!.*CONF)[A-Z0-9a-z_$()-]+'
#[^=]
find -mindepth 2 -type f -name "*.mk" | xargs -r grep -nPo '(?:.*CONF)[A-Z0-9a-z_$()-]+[[:space:]]+\+='
find -mindepth 2 -type f -name "*.mk" | xargs -r grep -nPo '(?![^=]*(?:.*CONF))[A-Z0-9a-z_$()-]+[[:space:]]+\+='
#(?=^((?![CE]).)*$)[A-Z]
