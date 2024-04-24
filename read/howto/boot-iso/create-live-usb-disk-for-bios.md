---
title: Create Live Usb Disk for Bios
nav_order: 7032
has_children: false
parent: Boot ISO
grand_parent: 如何
---


# Create Live Usb Disk for Bios




## 主題

* [硬碟分割規格](#硬碟分割規格)
* [硬碟分割操作](#硬碟分割操作)
* [相關議題](#相關議題)
* [參考文章](#參考文章)



## 硬碟分割規格

| Type | ID        | File system | Flags       | 用途                          |
| ---- | --------- | ----------- | ----------- | ---------------------------- |
| Disk | /dev/sdc  |             |             |                              |
| Part | /dev/sdc1 |             | `bios_grub` | 要採用傳統「BIOS」模式開機，Grub 有一部分的「開機Image」，會被安裝在這個「分割區」。   |
| Part | /dev/sdc2 | `ext4`      |             | Grub 一些相關的檔檔案，則是放在這個「分割區」， ISO檔案也會放在這個「分割區」 |

> 為了講解時的單純化，所以我們只有簡單地將整個「Disk」分割出「兩個分割區」。


## 硬碟分割操作

執行下面指令，先將「/dev/sdc*」的一些「`signature`」清除。

``` sh
sudo wipefs -a /dev/sdc*
```


執行下面指令，來「分割硬碟」。

``` sh

sudo parted --script -- "/dev/sdc" \
	mktable gpt \
	mkpart primary '0%' '2M' \
	mkpart primary '2M' '100%' \
	set 1 bios_grub on \
	print

```

顯示

```
Model: Kingston DataTraveler 3.0 (scsi)
Disk /dev/sdc: 124GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system  Name     Flags
 1      1049kB  2097kB  1049kB               primary  bios_grub
 2      2097kB  124GB   124GB                primary
```

執行下面指令，來將「`/dev/sdc2`」格式化成「`ext4`」。

``` sh
sudo mkfs.ext4 -L LIVEBIOS "/dev/sdc2"
```

執行下面指令，觀看「/dev/sdc」的分割資訊。

``` sh
sudo parted /dev/sdc print
```

顯示

```
Model: Kingston DataTraveler 3.0 (scsi)
Disk /dev/sdc: 124GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system  Name     Flags
 1      1049kB  2097kB  1049kB               primary  bios_grub
 2      2097kB  124GB   124GB   ext4         primary
```

或是執行下面指令，觀看「/dev/sdc」的分割資訊。包含「Free Space」也會顯示出來。

``` sh
sudo parted /dev/sdc print free
```

顯示

```
Model: Kingston DataTraveler 3.0 (scsi)
Disk /dev/sdc: 124GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system  Name     Flags
        17.4kB  1049kB  1031kB  Free Space
 1      1049kB  2097kB  1049kB               primary  bios_grub
 2      2097kB  124GB   124GB   ext4         primary
        124GB   124GB   1032kB  Free Space
```

若要「重新讀取裝置的 Partition Table」，可以執行下面指令

``` sh
sudo partprobe /dev/sdc
```




## 相關議題

| 相關議題 |
| --- |
| [Create Live Usb Disk for Uefi](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-uefi.html) |




## 參考文章

* 晚起的蟲 / [開始了解 GPT 並安裝 grub](http://amitmason.blogspot.com/2018/07/gpt.html)
* OsoLinux 快速安裝指南 / [UEFI  Live 啟動盤](https://osolinux.sourceforge.io/doc-1.html)
* G. T. Wang / [Linux 的 Parted 指令教學：建立、變更與修復磁碟分割區](https://blog.gtwang.org/linux/parted-command-to-create-resize-rescue-linux-disk-partitions/)
* Arch Wiki / [Parted](https://wiki.archlinux.org/title/Parted)
* Arch Wiki / [wipefs](https://wiki.archlinux.org/title/Device_file#wipefs)
* Arch Wiki / GRUB / [BIOS systems](https://wiki.archlinux.org/title/GRUB#BIOS_systems)
