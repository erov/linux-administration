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
```

