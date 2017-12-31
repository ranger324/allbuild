#grub-version checking
version_test_numeric()
{
  local retval ta tb
  #extract version number
  local a="$(echo $1 | cut -d - -f 2- | sed 's/-.*//')."
  local b="$(echo $2 | cut -d - -f 2- | sed 's/-.*//')."
  if [ "$a" = "$b" ] ; then
    return 0
  fi
  numpass=1
  while true; do
    [ -z "$(echo $a | cut -d . -f $numpass)" ] && ta="$a 0" || ta="$a $(echo $a | cut -d . -f $numpass)"
    [ -z "$(echo $b | cut -d . -f $numpass)" ] && tb="$b 0" || tb="$b $(echo $b | cut -d . -f $numpass)"
    [ "$(echo $ta | cut -d " " -f 2)" = "$(echo $tb | cut -d " " -f 2)" ] || break
    numpass=$(expr $numpass + 1)
  done
  if (echo $ta ; echo $tb) | sort -n -k 2 | cut -d " " -f 1 | head -n 1 | grep -qx $b ; then
    return 0
  else
    return 1
  fi
}
version_test_alphabetic()
{
  #extract kernel version
  local a=`echo $1 | cut -d - -f 2-`
  local b=`echo $2 | cut -d - -f 2-`
  if [ "$a" = "$b" ] ; then
    return 0
  fi
  if (echo $a ; echo $b) | sort | head -n 1 | grep -qx $b ; then
    return 0
  else
    return 1
  fi
}
version_find_latest()
{
  local n=$#
  local a=$(eval 'echo $'$n)
  for i in $@ ; do
    if version_test_numeric "$i" "$a" ; then
      a="$i"
    fi
  done
  echo "$a"
}

version_find_latest pkg-2.6.34.9-lt pkg-2.5.34.9-lt pkg-2.8.12.9-lt pkg-1.6.34.9 pkg-3.0 pkg-3.0f pkg-3.0e
