#!/bin/bash

set -euo pipefail

cd base

cat > init << EOF
#!/bin/busybox sh

mount -t devtmpfs  devtmpfs  /dev
mount -t proc      proc      /proc
mount -t sysfs     sysfs     /sys
mount -t tmpfs     tmpfs     /tmp

sh
EOF
chmod +x init

find . -mount | cpio -o -H newc | gzip -1 -c > /output/initramfs.img
