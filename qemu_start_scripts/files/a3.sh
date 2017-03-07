#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
/usr/libexec/qemu-kvm \
-m size=4194304k,slots=16,maxmem=16777216k \
-nographic \
-nodefaults \
-device vfio-pci,host=01:00.1,id=hostdev0,bus=pci.0,addr=0x4 \
-device vfio-pci,host=01:00.0,id=hostdev1,bus=pci.0,addr=0x5,multifunction=on \
-enable-kvm \
-vga none \
-cpu host,kvm=off,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff,hv_vendor_id=Nvidia43FIX \
-msg timestamp=on \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd
