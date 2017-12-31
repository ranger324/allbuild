#git clone https://github.com/davidgiven/ack
#git checkout gd0bfee1
  ( set -o pipefail
    git describe --tags --long | sed 's/^foo-//;s/\([^-]*-g\)/r\1/;s/-/./g' | sed 's/release.//g' | sed 's/.pre./pre/g' || \
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
  )
