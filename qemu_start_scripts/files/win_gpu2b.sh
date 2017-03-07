#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
qemu-system-x86_64 \
-enable-kvm \
-m 8192 \
-cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_vendor_id=Nvidia43FIX \
-vga none \
-nographic \
-usb -usbdevice host:06cb:0009 \
-usb -usbdevice host:04b3:3018 \
-usb -usbdevice host:04d9:a070 \
-usb -usbdevice host:04b3:3016 \
-device vfio-pci,host=01:00.0,multifunction=on \
-device vfio-pci,host=01:00.1 \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd \
-device virtio-scsi-pci,id=scsi \
-drive file=/home/oatakan/win10.iso,id=isocd,format=raw,if=none -device scsi-cd,drive=isocd \
-drive file=/mnt/temp_dir/win.img,id=disk,format=qcow2,if=none,cache=writeback -device scsi-hd,drive=disk \
-drive file=/home/oatakan/virt.iso,id=virtiocd,if=none,format=raw -device ide-cd,bus=ide.1,drive=virtiocd

