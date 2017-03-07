#!/bin/bash
 
cp /usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd /tmp/my_vars.fd
/usr/libexec/qemu-kvm \
-name guest=win10gm,debug-threads=on \
-machine pc-i440fx-rhel7.3.0,accel=kvm,usb=off \
-cpu Haswell-noTSX,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff \
-m size=4194304k,slots=16,maxmem=16777216k \
-realtime mlock=off \
-smp 2,maxcpus=16,sockets=16,cores=1,threads=1 \
-numa node,nodeid=0,cpus=0-1,mem=4096 \
-uuid 36e1b0ac-febf-4924-9fe7-305a1589eb00 \
-nographic \
-no-user-config \
-nodefaults \
-rtc base=2017-03-01T20:09:11,driftfix=slew \
-global kvm-pit.lost_tick_policy=discard \
-no-hpet \
-no-shutdown \
-boot strict=on \
-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x3 \
-device virtio-serial-pci,id=virtio-serial0,max_ports=16,bus=pci.0,addr=0x4 \
-drive file=/rhev/data-center/605a4733-3d8e-4a4c-a09c-18566787c566/32fcc0bb-30bb-48dc-9e0f-80470372cbb9/images/b18b966d-e1b8-41d7-8904-eb7fda96b8ce/b25e3acb-d9fc-403d-b77a-7236a73c4eb7,format=raw,if=none,id=drive-scsi0-0-0-0,serial=b18b966d-e1b8-41d7-8904-eb7fda96b8ce,cache=none,werror=stop,rerror=stop,aio=threads \
-device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 \
-chardev socket,id=charchannel0,path=/var/lib/libvirt/qemu/channels/36e1b0ac-febf-4924-9fe7-305a1589eb00.com.redhat.rhevm.vdsm,server,nowait \
-device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=com.redhat.rhevm.vdsm \
-chardev socket,id=charchannel1,path=/var/lib/libvirt/qemu/channels/36e1b0ac-febf-4924-9fe7-305a1589eb00.org.qemu.guest_agent.0,server,nowait \
-device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel1,id=channel1,name=org.qemu.guest_agent.0 \
-device vfio-pci,host=01:00.1,id=hostdev0,bus=pci.0,addr=0x5 \
-device vfio-pci,host=01:00.0,id=hostdev1,bus=pci.0,addr=0x6 \
-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x9 \
-object rng-random,id=objrng0,filename=/dev/urandom \
-device virtio-rng-pci,rng=objrng0,id=rng0,bus=pci.0,addr=0x7 \
-enable-kvm \
-vga none \
-cpu host,kvm=off,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff,hv_vendor_id=Nvidia43FIX \
-msg timestamp=on \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/tmp/my_vars.fd
