#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
/usr/libexec/qemu-kvm \
-m size=4194304k,slots=16,maxmem=16777216k \
-nographic \
-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x3 \
-drive file=/rhev/data-center/605a4733-3d8e-4a4c-a09c-18566787c566/32fcc0bb-30bb-48dc-9e0f-80470372cbb9/images/b18b966d-e1b8-41d7-8904-eb7fda96b8ce/b25e3acb-d9fc-403d-b77a-7236a73c4eb7,format=raw,if=none,id=drive-scsi0-0-0-0,serial=b18b966d-e1b8-41d7-8904-eb7fda96b8ce,cache=none,werror=stop,rerror=stop,aio=threads \
-device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 \
-device vfio-pci,host=01:00.1,id=hostdev0,bus=pci.0,addr=0x4 \
-device vfio-pci,host=01:00.0,id=hostdev1,bus=pci.0,addr=0x5,multifunction=on \
-enable-kvm \
-vga none \
-cpu host,kvm=off,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff,hv_vendor_id=Nvidia43FIX \
-msg timestamp=on \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd
