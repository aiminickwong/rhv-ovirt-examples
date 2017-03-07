#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
/usr/libexec/qemu-kvm \
-enable-kvm \
-m 8192 \
-cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_vendor_id=Nvidia43FIX \
-vga none \
-nographic \
-no-user-config \
-nodefaults \
-boot strict=on \
-usb -usbdevice host:06cb:0009 \
-usb -usbdevice host:04b3:3018 \
-usb -usbdevice host:04d9:a070 \
-usb -usbdevice host:04b3:3016 \
-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x3 \
-device vfio-pci,host=01:00.0,multifunction=on \
-device vfio-pci,host=01:00.1 \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd \
-drive file=/rhev/data-center/mnt/192.168.1.30:_export_iso/8a2492ae-d407-46e0-8342-4ce973450614/images/11111111-1111-1111-1111-111111111111/en_windows_10_multiple_editions_version_1511_x64_dvd_7223712.iso,format=raw,if=none,id=isocd \
-device scsi-cd,drive=isocd,bootindex=1 \
-device virtio-scsi-pci,id=scsi \
-drive file=/data/temp_dir/win.img,id=disk,format=qcow2,if=none,cache=writeback -device scsi-hd,drive=disk,bootindex=2
