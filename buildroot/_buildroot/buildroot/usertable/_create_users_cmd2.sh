#! /bin/sh

sh _test_include.sh
[ "$?" = 1 ] && rm -f tmpinclude.sh && x='./'

sh _create_users_cmd.sh > _cre_users_cmd.sh
source ${x}_cre_users_cmd.sh
