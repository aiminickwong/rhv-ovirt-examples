#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
/usr/libexec/qemu-kvm \
-machine pc-i440fx-rhel7.3.0,accel=kvm,usb=off \
-cpu Haswell-noTSX,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff \
-m size=4194304k,slots=16,maxmem=16777216k \
-realtime mlock=off \
-smp 2,maxcpus=16,sockets=16,cores=1,threads=1 \
-smbios type=1,manufacturer=oVirt,product="oVirt Node",version=7-3.1611.el7.centos,serial=F082B2BA-D2F8-E311-AA82-4439C44F6F72,uuid=36e1b0ac-febf-4924-9fe7-305a1589eb00 \
-numa node,nodeid=0,cpus=0-1,mem=4096 \
-uuid 36e1b0ac-febf-4924-9fe7-305a1589eb00 \
-nographic \
-no-user-config \
-nodefaults \
-usb -usbdevice host:06cb:0009 \
-usb -usbdevice host:04b3:3018 \
-usb -usbdevice host:04d9:a070 \
-usb -usbdevice host:04b3:3016 \
-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x3 \
-drive file=/data/temp_dir/win.img,id=disk,format=qcow2,if=none,cache=writeback \
-device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=disk,id=scsi0-0-0-0,bootindex=1 \
-device vfio-pci,host=01:00.1,id=hostdev0,bus=pci.0,addr=0x4 \
-device vfio-pci,host=01:00.0,id=hostdev1,bus=pci.0,addr=0x5,multifunction=on \
-enable-kvm \
-vga none \
-cpu host,kvm=off,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff,hv_vendor_id=Nvidia43FIX \
-msg timestamp=on \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd
