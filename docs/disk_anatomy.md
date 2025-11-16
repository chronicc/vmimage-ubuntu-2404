Anatomy of a Disk
=================

Partition Layout
----------------

### MBR / GPT Gap

The gap is where the MBR (Master Boot Record) or the GPT (GUID Partition Table) is stored. It sits before the first
partition and usually has the size of 1Mb. On a default sector size of 512 bytes, this is 2048 sectors. The reason for
this is to be aligned with the 4KB physical sector size of modern disks.

### Boot Partition

The boot partition contains the bootloaders and drivers that are loaded by legacy BIOS firmware. It also needs to
be set bootable for the bootloader to be executed during the start of the machine. It usually has a size of 4MB.

- **Type:** BIOS Boot (21686148-6449-6e6f-744e656564454649)

### EFI Partition

The EFI partition contains the bootloaders and drivers that are loaded by the UEFI firmware during the start of the
machine.

- **Type:** EFI System (C12A7328-F81F-11D2-BA4B-00A0C93EC93B)

### System Partition

The system partition contains the operating system and will be entered through the bootloader.

- **Type:** Linux Filesystem (0FC63DAF-8483-4772-8E79-3D69D8477DE4)

Sources
-------

- <https://www.gnu.org/software/grub/manual/grub/html_node/BIOS-installation.html>
- <https://wiki.inonet.com/uefi-vs-bios>
- <https://www.youtube.com/watch?v=nUJ_JKxYPZo&t=225s>
- <https://jdebp.uk/FGA/disc-partition-alignment.html>
