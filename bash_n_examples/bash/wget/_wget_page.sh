#wget -r -l 1 -np -k
#--domains host.com
#--no-clobber --page-requisites --html-extension
#-e robots=off
#-P dir
#-A jpeg,jpg,png,html
wget -r -l 1 -np -A gz,xz host.com/dir
wget -E -H -k -p --html-extension https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
