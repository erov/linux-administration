# 1

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

Created new partition 3 pf type 'Linux' and size 300Mib

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


# 2

```
> touch ~/sda3_uuid && blkid /dev/sda3 | cut -d "\"" -f2 > ~/sda3_uuid
> cat ~/sda3_uuid
b86d2976-03
```

# 3

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


# 4

```
> dumpe2fs /dev/sda3
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

# 5
```
> tune2fs -c 2 -i 2m /dev/sda3
tune2fs 1.45.4 (23-Sep-2019)
Setting maximal mount cout to 2
Setting interval between checks to 5184000 seconds
```

# 6
