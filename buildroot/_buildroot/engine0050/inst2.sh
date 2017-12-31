rm -f output/build/inst_start.log
make -s BR2_INSTRUMENTATION_SCRIPTS="/root/buildroot-2017.05-rc2/targz_packages" tgt-list
