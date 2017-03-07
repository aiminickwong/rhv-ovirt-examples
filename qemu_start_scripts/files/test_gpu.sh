#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
qemu-system-x86_64 \
-enable-kvm \
-m 2048 \
-cpu host,kvm=off \
-vga none \
-nographic \
-device vfio-pci,host=05:00.0,multifunction=on \
-device vfio-pci,host=05:00.1 \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd
