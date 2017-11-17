lftp ftp://unaux_20423207@ftp.unaux.com
set ftp:ssl-allow no
lftp ftp://unaux_20423207@ftp.unaux.com -e "set ftp:ssl-allow no; mirror -R $outdir $ftp_target; quit"
echo "set ssl:verify-certificate no" >> ~/.lftp/rc
