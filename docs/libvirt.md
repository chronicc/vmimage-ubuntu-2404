libvirt
=======

virt-install
------------

The virt-install binary helps with creating a virtual machine (which is usually defined as xml document) by using
commandline arguments. Elements from the [Domain XML format](https://libvirt.org/formatdomain.html) are translated into
dot notation starting with the second level. The first level (guest property) is represented as the cli argument of
virt-install and has not always a direct translation.

### Example

```xml
<os firmware="efi">
  <firmware>
    <feature enabled="false" name="secure-boot"/>
  </firmware>
</os>
```
is translated into `--boot firmware.feature0.name=secure-boot,firmware.feature1.enabled=no`.

### Guest Property Translation

- **blkiotune:** `--blkiotune`
- **clock:** `--clock`
- **cpu:** `--cpu`
- **cputune:** `--cputune`
- **devices.audio:** `--audio`
- **devices.channel:** `--channel`
- **devices.console:** `--console`
- **devices.controller:** `--controller`
- **devices.disk:** `--disk`
- **devices.filesystem:** `--filesystem`
- **devices.graphics:** `--graphics`
- **devices.hostdev:** `--hostdev`
- **devices.input:** `--input`
- **devices.interface:** `--network`
- **devices.iommu:** `--iommu`
- **devices.memballoon:** `--memballoon`
- **devices.memory:** `--memdev`
- **devices.panic:** `--panic`
- **devices.parallel:** `--parallel`
- **devices.pstore:** `--pstore`
- **devices.redirdev:** `--redirdev`
- **devices.rng:** `--rng`
- **devices.serial:** `--serial`
- **devices.shmem:** `--shmem`
- **devices.smartcard:** `--smartcard`
- **devices.sound:** `--sound`
- **devices.tpm:** `--tpm`
- **devices.video:** `--video`
- **devices.vsock:** `--vsock`
- **devices.watchdog:** `--watchdog`
- **features:** `--features`
- **idmap:** `--idmap`
- **iothreads:** `--iothreads`
- **keywrap:** `--keywrap`
- **launchSecurity:** `--launchSecurity`
- **memoryBacking:** `--memorybacking`
- **memtune:** `--memtune`
- **numatune:** `--numatune`
- **os:** `--boot`
- **pm:** `--pm`
- **resource:** `--resource`
- **seclabels:** `--seclabel`
- **sysinfo:** `--sysinfo`
- **xmlns_qemu:** `--qemu_commandline`
