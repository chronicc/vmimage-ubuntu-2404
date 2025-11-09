VM Image: Ubuntu 24.24
======================

Getting Started
---------------

### Install dependencies

#### Ubuntu

```shell
apt install libguestfs-tools libvirt-clients qemu-system virtinst
```

### Build the virtual machine image

```shell
# Download the Ubuntu cloud-image enabled image befor running the command
./build-qemu.sh ./noble-server-cloudimg-amd64.img --os-variant ubuntu24.04
```

The built image can be found under `build/qemu/disk.qcow2`.

### Credentials

The default login for this image is `ubuntu:ubuntu`.
