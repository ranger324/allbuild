use strict;
use POSIX;
use Fcntl;
use POSIX ":fcntl_h"; #S_ISLNK was here until 5.6
import Fcntl ":mode" unless defined &S_ISLNK; #and is now here
my $dirname = $ARGV[0];
if (opendir (DIR, $dirname)) {
while((my $filename = readdir (DIR))){
    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = lstat("$dirname/$filename");
    my $mloctime= strftime("%%m-%%d-%%Y %%H:%%M", localtime $mtime);
    my $strutils_shell_escape_regex = s/([;<>\*\|`&\$!#\(\)\[\]\{\}:'\''"\ \\])/\\$1/g;
    my $e_filename = $filename;
    $e_filename =~ $strutils_shell_escape_regex;
    if (S_ISLNK ($mode)) {
        my $linkname = readlink ("$dirname/$filename");
        $linkname =~ $strutils_shell_escape_regex;
        printf("R%%o %%o $uid.$gid\nS$size\nd$mloctime\n:\"%%s\" -> \"%%s\"\n\n", S_IMODE($mode), S_IFMT($mode), $e_filename, $linkname);
    } elsif (S_ISCHR ($mode) || S_ISBLK ($mode)) {
        my $minor = $rdev %% 256;
        my $major = int( $rdev / 256 );
        printf("R%%o %%o $uid.$gid\nE$major,$minor\nd$mloctime\n:\"%%s\"\n\n", S_IMODE($mode), S_IFMT($mode), $e_filename);
    } else {
        printf("R%%o %%o $uid.$gid\nS$size\nd$mloctime\n:\"%%s\"\n\n", S_IMODE($mode), S_IFMT($mode), $e_filename);
    }
}
    printf("### 200\n");
    closedir(DIR);
} else {
    printf("### 500\n");
}
exit 0
