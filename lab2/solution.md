# task 1

```
> blkid
/dev/sda1: UUID="1f1297b3-3cf3-4a12-820a-c63b70b17a6a" TYPE="ext4" PARTUUID="b86d2976-01"
/dev/sda2: UUID="eiQBLp-xTK9-TVsh-Cc4T-83nq-qdfl-zYa4Kk" TYPE="LVM2_member" PARTUUID="b86d2976-02"
/dev/mapper/cl-root: UUID="f2591335-a125-4cd4-8fe7-61862c1c4864" TYPE="ext4"
/dev/mapper/cl-swap: UUID="e91059d5-14da-4af1-8c40-a7f3b5c0b51b" TYPE="swap"
/dev/mapper/cl-home: UUID="608bb71f-e67b-4278-8e58-ccfa03d59d9a" TYPE="xfs"


> fdisk /dev/sda
Partition type
  p   primary (2 primary, 0 extended, 2 free)
  e   extended (container for logical partitions)
Select (defauplt p)
> p
Partition number (3,4, default 3):   # cause /dev/sda1 & /dev/sda2 are already exist
> 3
First sector:
>   # use default -- first free one
Last sector, +sectors or +size{K,M,G,T,P}:
> +300M

Created new partition 3 pf type 'Linux' and of size 300MiB

> w

The partition table has been altered.
Syncing disks.


> blkid
/dev/sda1: UUID="1f1297b3-3cf3-4a12-820a-c63b70b17a6a" TYPE="ext4" PARTUUID="b86d2976-01"
/dev/sda2: UUID="eiQBLp-xTK9-TVsh-Cc4T-83nq-qdfl-zYa4Kk" TYPE="LVM2_member" PARTUUID="b86d2976-02"
/dev/mapper/cl-root: UUID="f2591335-a125-4cd4-8fe7-61862c1c4864" TYPE="ext4"
/dev/mapper/cl-swap: UUID="e91059d5-14da-4af1-8c40-a7f3b5c0b51b" TYPE="swap"
/dev/mapper/cl-home: UUID="608bb71f-e67b-4278-8e58-ccfa03d59d9a" TYPE="xfs"
/dev/sda3: PARTUUID="b86d2976-03"
```


# task 2

```
> touch ~/sda3_uuid && blkid /dev/sda3 | cut -d "\"" -f2 > ~/sda3_uuid
> cat ~/sda3_uuid
b86d2976-03
```

# task 3

```
> mkfs.ext4 /dev/sda3 4096
mkefs 1.54.3 (23-Sep-2019)
Creating filesystem with 4096 1k blocks and 1024 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

> blkid /dev/sda3
/dev/sda3: UUID="87f169b9-f2fb-43d0-80be-04367d05a404" TYPE="ext4" PARTUUID="b86d2976-03"


> mkfs.ext4 -b 4096 /dev/sda3
mke2fs 1.54.4 (23-Sep-2019)
/dev/sda3 contains a ext4 file system
        created on Fri Dec  2 03:21:23 2022
Proceed anyway? (y,N)
> y
Creating filesystem with 76800 4k blocks and 76800 inodes
Filesystem UUID: 24178d26-d8b5-4085-8fed-6ebb8f83c4dd
Superblock stored on blocks:
        32768
        
Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

> blkid /dev/sda3
/dev/sda3: UUID="24178d26-d8b5-4085-8fed-6ebb8f83c4dd" TYPE="ext4" PARTUUID="b86d2976-03"
```


# task 4

```
> dumpe2fs -h /dev/sda3
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          24178d26-d8b5-4085-8fed-6ebb8f83c4dd
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              76800
Block count:              76800
Reserved block count:     3840
Free blocks:              70214
Free inodes:              76789
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      37
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         25600
Inode blocks per group:   800
Flex block group size:    16
Filesystem created:       Fri Dec  2 03:40:30 2022
Last mount time:          n/a
Last write time:          Fri Dec  2 03:40:30 2022
Mount count:              0
Maximum mount count:      -1
Last checked:             Fri Dec  2 03:40:30 2022
Check interval:           0 (<none>)
Lifetime writes:          173 kB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          128
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      3f30631f-eae6-469a-b23a-b925a7abadd9
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x941e17dd
Journal features:         (none)
Journal size:             16M
Journal length:           4096
Journal sequence:         0x00000001
Journal start:            0

```

# task 5

```
> tune2fs -c 2 -i 2m /dev/sda3
tune2fs 1.45.4 (23-Sep-2019)
Setting maximal mount cout to 2
Setting interval between checks to 5184000 seconds
```

# task 6

```
> mkdir /mnt/newdisk
> mount -t ext4 /dev/sda3 /mnt/newdisk
[ 6622.845207 ] EXT4-fs (sda3): mounted filesystem eith ordered data mode. Opts: (null)
```

# task 7

```
> ln -s /mnt/newdisk ~/newdisk
> ls -l ~
total 12
-rw-------. 1 root root 1943 Aug 28  2020 anaconda-ks.cfg
lrwxrwxrwx. 1 root root   12 Dec  2 03:58 newdisk -> /mnt/newdisk
-rw-r--r--. 1 root root   12 Dec  2 03:15 sda3_uuid
drwxr-xr-x. 2 root root 4096 Nov 11  2021 test
```


# task 8

```
> mkdir ~/newdisk/test
> ls -l ~/mnt/newdisk
total 24
drwx------. 2 root root 16384 Dec  2 03:40 lost+found
drwxr-xr-x. 2 root root  4096 Dec  2 04:00 test
```

# task 9

```
> sudo echo "/dev/sda3    /mnt/newdisk    ext4    noexec,noatime    0 0" >> /etc/fstab
> cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Fri Aug 28 00:12:19 2020
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
/dev/mapper/cl-root     /                       ext4    defaults        1 1
UUID=1f1297b3-3cf3-4a12-820a-c63b70b17a6a /boot                   ext4    defaults        1 2
/dev/mapper/cl-home     /home                   xfs     defaults        0 0
/dev/mapper/cl-swap     swap                    swap    defaults        0 0
/dev/sda3    /mnt/newdisk    ext4    noexec,noatime    0 0

> sudo reboot

> nano ~/newdisk/hello.sh
> #!/bin/bash
> echo "Hello, world!"
>

> ls ~/newdisk
total 32
-rw-r--r--. 1 root root    34 Dec  2 04:29 hello.sh
drwx------. 2 root root 16384 Dec  2 03:40 lost+found
drwxr-xr-x. 2 root root  4096 Dec  2 04:00 test

> bash ~/newdisk/hello.sh
Hello, world!

> runuser -l user -c 'bash /root/newdisk/hello.sh'
bash: /root/newdisk/hello.sh: Permission denied
```

# task 10

```
> umount /dev/sda3

> fdisk /dev/sda
> d
Partition number (1-3, default 3):
> 3
Partition 3 has been deleted.
> n
Partition type
  p   primary (2 primary, 0 extended, 2 free)
  e   extended (container for logical partitions)
Select (defauplt p)
> p
Partition number (3,4, default 3):
> 3
First sector:
>   # use default -- first free one
Last sector, +sectors or +size{K,M,G,T,P}:
> +350M

Created new partition 3 pf type 'Linux' and of size 350MiB
Partition #3 contains a ext4 signature.

Do you want ti remove the signature? [Y]es/[N]o:
> No

> p
Device      Boot    Start       End   Sectors   Size  Id  Type
/dev/sda1   *        2048   2099199   2097152     1G  83  Linux
/dev/sda2         2099200  14551039  12451840     6G  8e  Linux LVM
/dev/sda3        14551040  15267839    716800   350M  83  Linux

> w
The partition table has been altered.
Syncing disks.


> resize2fs /dev/sda3
Please run 'e2fsck -f /dev/sda3' first

> e2fsck -f /dev/sda3
...

> resize2fs /dev/sda3
...

> sudo reboot
> df -h ~/newdisk
Filesystem    1M-blocks Used  Available Use% Mounted on
/dev/sda3           325    1        300   1% /mnt/newdisk
```

# task 11

Weird, but ok:
```
> e2fsck -n /dev/sda3
Warning! /dev/sda3 is mounted.
Warning: skipping journal recovery because doing a read-only filesystem check.
/dev/sda3: clean, 13/76000 files, 6589/89600 blocks (check after next mount).
```

# task 12

```
> fdisk /dev/sda
> n
Partition type...
> p
Selected partition 4
First sector...
>
Last sector...
> +12M

Created a new partition 4 of type 'Linux' and of size 12Mib

> w
The partition table has been altered.
Syncing disks.

> mke2fs -O journal_dev /dev/sda4 -b 4096
Creating filesystem with 3072 4k blocks and 0 inodes
Filesustem UUID: <some-hash>
Superblock backups stored on blocks:

Zeroing joirnal device:
> umount /dev/sda3
> mke2fs -t ext4 -J device=/dev/sda4 /dev/sda3 -b 4096
/dev/sda3 contains a ext4 file system
        last munted on /mnt/newdisk on <Date>
Procced anyway? (y,N)
> y
Creating filesystem with 4096 1k blocks and 1024 inodes
Filesystem UUID: <some hash>
Superblock backups stored on blocks:
        32768

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

# task 13

У меня закончились доступные разделы :(
```
> fdisk /dev/sda
> d
Partition number:
> 3

Partition 3 has been deleted.

> d
Partition number:
> 4

Partition 4 has been deleted.

> n
Partition type...
> p
Partition number...
> 3
First sector...
> 
Last sector...
> +100M

Created a new partition 3 of type 'Linux' and of size 100MiB.
Partition #3 contins a ext4 signature.
Do you want to remove the signature?
> Y
The signature will be remove by a write command.

> n
Partition type...
> p
Selected partition 4
First sector...
> 
Last sector...
> +100M

Created a new partition 4 of type 'Linux' and of size 100MiB.

> w
The partition table has been altered.
Syncing disks.

```

# task 14

```
> pvcreate /dev/sda3 /dev/sda4
  Physical volume "/dev/sda3" successfully created.
  Physical volume "/dev/sda4" successfully created.
>  vgcreate /dev/sda3 /dev/sda4
  Volume group "VG_sda3_sda4" successfully created.
> lvcreate --size 180m VG_sda3_sda4
  Logical volume "lvol0" created.
> mkdir /mnt/supernewdisk
> ls /dev
...
> ls /dev/VG_sda3_sda4
lvol0
> mkfs.ext4 /dev/VG_sda3_sda4/lvol0
Creating filesystem with 184320 1k blocks and 46184 inodes.
...
> mount /dev/VG_sda3_sda4/lvol0 /mnt/supernewdisk
[ Timestamp ] EXT4-fs (dm-3): mounted filesystem with ordered data mode.Opts: (null)
> ls /mnt/supernewdisk
lost+found
> df -h /mnt/supernewdisk/
Filesystem                      Size  Used Avail  Use%  Mounted on
/dev/mapper/VG_sda3_sda4-lvol0  171M  1.6M  157M    1%  /mnt/supernewdisk
``` 

# task 15

Открыл директорию ```\\EROVE-DESKTOP\set-exam-iamerove``` на чтение для пользователя ```root```.

```
> mkdir /mnt/share
> sudo smbpasswd -a root
> mount -t cifs //192.168.56.1/set-exam-iamerove /mnt/share -o vers=3.1.1
Password for root@//192.168.56.1/set-exam-iamerove: ********
[ Timestamp ] CIFS: Attempting to mount //192.168.56.1/set-exam-iamerove
> ls /mnt/share
...
```

# task 16

```
> echo "//192.168.56.1/set-exam-iamerove  /mnt/share  cifs  ro,vers=3.1.1,user=root,password=rootroot" >> /etc/fstab
> umount /mnt/share
> reboot
> ls /mnt/share
...
```
