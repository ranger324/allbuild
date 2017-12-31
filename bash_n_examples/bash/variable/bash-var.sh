A="12.12.12.23.12.23.12"; echo "${A%23*}"
A="12.12.12.23.12.23.12"; echo "${A%%23*}"
A="12.12.12.23.12.23.12"; echo "${A#*23}"
A="12.12.12.23.12.23.12"; echo "${A##*23}"
A="12.12.12.23.12.23.12"; echo "${A%12}"
A="12.12.12.23.12.23.12"; echo "${A#12}"

A="ASASDD-D-F-G"
echo _ ${A}
echo 2 ${A%-*}
echo 3 ${A#*-}
echo 4 ${A/AS/ES}
echo 5 ${A//AS/ES}
echo 6 ${A/#AS/ES}
echo 6 ${A/%AS/ES}
echo 7 ${A/%-G/ES}
[ "${A/AS/}" != "${A}" ] && echo 8 ${A/AS/}
A=123; echo 9 ${A#??}

echo 2 ${A%%}
echo 3 ${A##}

#[] charlist or range
#* 0 or more any char
#? one char
#*[]?

#suffix
#${ARCHIVE/%/asd}
#prefix
#${ARCHIVE/#/asd}

#${ARCHIVE/%.tar.bz[0-9]/}
#${ARCHIVE/%.tar.bz2/}
#RC=${WO_EXT/#$WO_RC/}
