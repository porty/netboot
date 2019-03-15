#!/bin/bash

set -euxo pipefail

rm -rf root && mkdir root
go build -o root/init


rm -rf output
mkdir output

(
    cd root
    find . | cpio -o -H newc | gzip -1 -c > ../output/initramfs.img.gz
)

