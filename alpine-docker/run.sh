#!/bin/bash

set -euo pipefail

qemu-system-x86_64 -kernel /boot/vmlinuz-linux -initrd output/initramfs.img # -nographic -append 'console=ttyS0'
