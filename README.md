VM Image: Ubuntu 24.24
======================

Getting Started
---------------

### Install dependencies

#### Ubuntu

```shell
sudo apt install \
  libguestfs-tools \
  libnbd-bin \
  libvirt-clients \
  qemu-kvm \
  libvirt-daemon-system \
  virtinst
```

### Build the virtual machine image

```shell
# Download the Ubuntu cloud-image enabled image before running the command
./build-qemu.sh noble-server-cloudimg-amd64.img --os-variant ubuntu24.04
```

The built image can be found under `build/qemu/disk.qcow2`.

### Credentials

The default login for this image is `ubuntu:ubuntu`.

Additional Topics
-----------------

- [Disk Anatomy](./docs/disk_anatomy.md)
- [Libvirt](./docs/libvirt.md)
- [Network Block Device](./docs/nbd.md)
- [Qemu](./docs/qemu.md)

External Resources
------------------

- [Forencics Wiki](https://forensics.wiki/)
