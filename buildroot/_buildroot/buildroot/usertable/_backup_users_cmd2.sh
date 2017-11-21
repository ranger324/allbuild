#! /bin/sh

sh _test_include.sh
[ "$?" = 1 ] && rm -f tmpinclude.sh && x='./'

sh _backup_users_cmd.sh > _bck_users_cmd.sh
source ${x}_bck_users_cmd.sh
