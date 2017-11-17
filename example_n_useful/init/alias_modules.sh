find /sys -name modalias -print0 | xargs -r -0 sort -u -z | xargs -0 modprobe -abq
