perl -e '
use strict;
use POSIX;
use Fcntl;
my $filename = $ARGV[0];
my $pos = $ARGV[1];
my $content;
my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = lstat("$filename");
my $n;
if (open IFILE,$filename) {
    if ($size<$pos) {
        printf("0\n");
    } else {
        $size-=$pos;
        printf("$size\n");
    }
    printf("### 100\n");
    seek (IFILE, $pos, 0);
    while ($n = read(IFILE,$content,$blksize)!= 0) {
        print $content;
    }
    close IFILE;
    printf("### 200\n");
} else {
    printf("### 500\n");
}
exit 0
'
