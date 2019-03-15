#!/bin/bash

set -euo pipefail

mkdir -p cache
if ! [ -f cache/busybox ] ; then
    curl -L -o cache/busybox https://www.busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64
fi
chmod +x cache/busybox

rm -rf root
mkdir -p root/{bin,dev,etc,lib,mnt,proc,sbin,sys,tmp,var}
cp cache/busybox root/bin/

(
    set -euo pipefail
    
    cd root/bin
    for x in $(./busybox --list) ; do
        ln -s busybox "$x"
    done
)

cat > root/init << EOF
#!/bin/busybox sh

mount -t devtmpfs  devtmpfs  /dev
mount -t proc      proc      /proc
mount -t sysfs     sysfs     /sys
mount -t tmpfs     tmpfs     /tmp

sh
EOF
chmod +x root/init

rm -rf output && mkdir output
(
    cd root
    find . | cpio -ov --format=newc | gzip -1 -c > ../output/initram.cpio.gz
)

