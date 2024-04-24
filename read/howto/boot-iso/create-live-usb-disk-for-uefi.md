---
title: Create Live Usb Disk for Uefi
nav_order: 7031
has_children: false
parent: Boot ISO
grand_parent: 如何
---


# Create Live Usb Disk for Uefi




## 主題

* [完整腳本範例](#完整腳本範例)
* [緣起](#緣起)
* [操作環境](#操作環境)
* [操作背景](#操作背景)
* [硬碟分割規格](#硬碟分割規格)
* [硬碟分割操作](#硬碟分割操作)
* [掛載分割區](#掛載分割區)
* [產生「/EFI/BOOT/bootx64.efi」](#產生efibootbootx64efi)
* [grub-install](#grub-install)
* [產生「/EFI/grub/grub.cfg」](#產生efigrubgrubcfg)
* [grub-theme](#grub-theme)
* [下載ISO檔](#下載iso檔)
* [相關議題](#相關議題)
* [參考文章](#參考文章)




## 完整腳本範例

| 範例 |
| --- |
| [demo-create-live-usb-disk-for-uefi-start](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-usb-disk/uefi/demo-create-live-usb-disk-for-uefi-start/prototype) |




## 緣起

以前我會下面幾種方式來「Boot ISO」

1. [透過「dd」](https://samwhelp.github.io/note-about-debian/read/core/iso/boot-iso/boot-iso-by-usb.html)
2. [透過「Ventoy」](https://samwhelp.github.io/note-about-ventoy/#%E5%85%A5%E9%96%80)
3. [透過既有的系統，撰寫「GRUB Menu Entry」](https://samwhelp.github.io/note-about-grub/read/howto/boot_iso.html)
來「Boot ISO」

一直以來想要去嘗試第四種方式，來「Boot ISO」

4. 將「GRUB」單獨安裝在「USB DISK」，撰寫「GRUB Menu Entry」，來「Boot ISO」

不過以前只有概念，不知道如何下手。

這幾天剛好看到兩篇文章，「[文章一](https://osolinux.sourceforge.io/doc-1.html)」，「[文章二](http://amitmason.blogspot.com/2018/07/gpt.html)」，

結合之前學會的概念，實際動手去實驗，

終於了解到如何製作，

以下就是紀錄相關的操作步驟。

有兩種版本，本篇是「**UEFI版**」，另一篇是「[BIOS版](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-bios.html)」。




## 操作環境

> 我撰寫此篇的內容，是在「Debian 12 Bookworm」完成的。

> GRUB 的版本是「2.06」

執行

``` sh
sudo grub-install --version
```

顯示

```
grub-install (GRUB) 2.06-13+deb12u1
````




## 操作背景

我操作的機器是「筆電」，有在筆電內建的硬碟安裝「Linux」，

並且完全沒有「Windows」系統。

內建硬碟的「Device ID」是「**/dev/sda**」。

而我最近都是安裝不同的「Linux」系統，到外接的「USB Disk」。

然後使用外接的「USB Disk」來開機。

我是使用傳統的「BIOS模式」來開機，並不是使用「UEFI模式」來開機。

開機的「USB Disk」的「Device ID」是「**/dev/sdb**」。

而此篇所要產生的「ｌive USB Disk」的「Device ID」則是「**/dev/sdc**」。




## 硬碟分割規格

| Type | Device ID | File System | Flags | 用途                          |
| ---- | --------- | ----------- | ----- | ---------------------------- |
| Disk | /dev/sdc  |             |       |                              |
| Part | /dev/sdc1 | `fat32`     | `esp` | 用來當作「EFI」開機的「分割區」， ISO檔案也會放在這個「分割區」 |


> 為了講解時的單純化，所以我們只有簡單地將整個「Disk」分割出「一個分割區」，用來當作「EFI」開機的「分割區」。


## 硬碟分割操作

執行下面指令，先將「/dev/sdc*」的一些「`signature`」清除。

``` sh
sudo wipefs -a /dev/sdc*
```


執行下面指令，來「分割硬碟」。

``` sh

sudo parted --script -- "/dev/sdc" \
	mktable gpt \
	mkpart primary '0%' '100%' \
	set 1 esp on \
	print

```

顯示

```
Model: Kingston DataTraveler 3.0 (scsi)
Disk /dev/sdc: 124GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End    Size   File system  Name     Flags
 1      1049kB  124GB  124GB               primary  boot, esp
```

執行下面指令，來將「`/dev/sdc1`」格式化成「`fat32`」。

``` sh
sudo mkfs.fat -F 32 -n LIVEUEFI "/dev/sdc1"
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

Number  Start   End    Size   File system  Name     Flags
 1      1049kB  124GB  124GB  fat32        primary  boot, esp
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
 1      1049kB  124GB   124GB   fat32        primary  boot, esp
        124GB   124GB   1032kB  Free Space
```

若要「重新讀取裝置的 Partition Table」，可以執行下面指令

``` sh
sudo partprobe /dev/sdc
```

若是要觀看「/dev/sdc1」的一些「Lable」或「UUID」，可以執行下面指令

``` sh
sudo blkid /dev/sdc1
```

若是要觀看「/dev/sdc*」的一些「Lable」或「UUID」，可以執行下面指令

``` sh
sudo blkid /dev/sdc*
```




## 掛載分割區

執行下面指令，產生「mnt」這個「資料夾」。

``` sh
mkdir -p ./mnt
```

執行下面指令，確保「mnt」這個資料夾沒有掛載分割區。

``` sh
sudo umount ./mnt
```

執行下面指令，確保「/dev/sdc1」沒有被掛載。

``` sh
sudo umount /dev/sdc1
```

執行下面指令，將「/dev/sdc1」掛載到「mnt」。

``` sh
sudo mount /dev/sdc1 ./mnt
```




## 產生「/EFI/BOOT/bootx64.efi」


``` sh
sudo mkdir -p mnt/EFI/BOOT mnt/EFI/grub
```

執行

``` sh
tree mnt
```

顯示

```
mnt/
└── EFI
    ├── BOOT
    └── grub

4 directories, 0 files
```

執行下面指令，將「/usr/lib/grub/x86_64-efi」這個資料夾內的所有檔案，複製到「mnt/EFI/grub/x86_64-efi」這個資料夾。

``` sh
sudo cp /usr/lib/grub/x86_64-efi/. mnt/EFI/grub/x86_64-efi -rf
````

若是沒有「/usr/lib/grub/x86_64-efi」這個資料夾，請先執行下面指令安裝「[grub-efi-amd64-bin](https://packages.debian.org/bookworm/grub-efi-amd64-bin)」。

``` sh
sudo apt-get install grub-efi-amd64-bin
```

* Debian Package / grub-efi-amd64-bin / [File list](https://packages.debian.org/bookworm/amd64/grub-efi-amd64-bin/filelist)


執行下面指令，產生「mnt/EFI/BOOT/bootx64.efi」這個檔案

``` sh

sudo grub-mkimage \
	-O x86_64-efi \
	-o mnt/EFI/BOOT/bootx64.efi \
	-d mnt/EFI/grub/x86_64-efi \
	-p /EFI/grub \
		fat \
		iso9660 \
		part_gpt \
		part_msdos \
		normal \
		boot \
		linux \
		linux16 \
		configfile \
		loopback \
		chain \
		efifwsetup \
		efi_gop \
		efi_uga \
		ls \
		search \
		search_label \
		search_fs_uuid \
		search_fs_file \
		gfxterm \
		gfxterm_background \
		gfxterm_menu \
		test \
		all_video \
		loadenv \
		exfat \
		ext2 \
		ntfs \
		btrfs \
		hfsplus \
		udf \
		cat

```

執行

``` sh
file mnt/EFI/BOOT/bootx64.efi
```

顯示

```
mnt/EFI/BOOT/bootx64.efi: PE32+ executable (EFI application) x86-64 (stripped to external PDB), for MS Windows, 4 sections
```




## grub-install

> 接下來我們要手動補足「grub」開機時，我們有可能會用到的檔案。

``` sh
sudo cp /boot/grub/fonts/. mnt/EFI/grub/fonts -rf

sudo cp /boot/grub/locale/. mnt/EFI/grub/locale -rf
```




## 產生「/EFI/grub/grub.cfg」

產生「/EFI/grub/grub.cfg」這個關鍵的設定檔，內容類似如下

``` sh

set pager=1




##
## ## Load Module
##

insmod all_video
insmod video_bochs
insmod video_cirrus
insmod font
insmod gfxterm
insmod gfxmenu
insmod gettext
insmod jpeg
insmod png




##
## ## Locale
##

loadfont ($root)/EFI/grub/fonts/unicode.pf2
set locale_dir=($root)/EFI/grub/locale
set lang=zh_TW




##
## Resolution
##

set gfxmode=auto
terminal_output gfxterm




##
## ## Theme
##

background_image ($root)/EFI/grub/themes/grub-theme-darkmatter-remix/background.jpg
set theme=($root)/EFI/grub/themes/grub-theme-darkmatter-remix/theme.txt
export theme




##
## ## Countdown
##

set timeout=5




##
## ## Color
##

set color_normal=white/black
set color_highlight=white/cyan




##
## ## Grub Menu Entry
##

menuentry "Debian 12 ISO / Xfce" --class Debian {
	set iso_file="/iso/debian-live-12.5.0-amd64-xfce.iso"
	search --set=iso_partition --no-floppy --file $iso_file
	probe --set=iso_partition_uuid --fs-uuid $iso_partition
	set img_dev="/dev/disk/by-uuid/$iso_partition_uuid"
	loopback loop ($iso_partition)$iso_file
	set boot_option=""
	#set boot_option="components splash quiet"
	#set boot_option="components locales=zh_TW.UTF-8 quiet splash"
	linux (loop)/live/vmlinuz boot=live buuid=$iso_partition_uuid findiso=$iso_file $boot_option
	initrd (loop)/live/initrd.img
}


menuentry "Fedora 40 Beta ISO / Kde Plasma" {
	set iso_file=/iso/Fedora-KDE-Live-x86_64-40_Beta-1.10.iso
	loopback loop $iso_file
	linux (loop)/images/pxeboot/vmlinuz iso-scan/filename=$iso_file root=live:CDLABEL=Fedora-KDE-Live-40_B-1-10 rd.live.image rhgb $boot_option
	initrd (loop)/images/pxeboot/initrd.img
}

```




## grub-theme

``` sh
set theme=($root)/EFI/grub/themes/grub-theme-darkmatter-remix/theme.txt
```

上面的設定，我是採用「[grub-theme-darkmatter-remix](https://github.com/samwhelp/grub-theme-remix/tree/grub-theme-darkmatter-remix)」。


所以執行下面的指令，下載下來，並且解壓縮，放置到「mnt/EFI/grub/themes/grub-theme-darkmatter-remix」這個路徑。

``` sh

mkdir -p tmp


wget -c "https://github.com/samwhelp/grub-theme-remix/archive/refs/heads/grub-theme-darkmatter-remix.tar.gz" -O "tmp/grub-theme-remix-grub-theme-darkmatter-remix.tar.gz"

tar xf "tmp/grub-theme-remix-grub-theme-darkmatter-remix.tar.gz" -C "tmp"

sudo mkdir -p "mnt/EFI/grub/themes"

sudo cp -rf "tmp/grub-theme-remix-grub-theme-darkmatter-remix/." "mnt/EFI/grub/themes/grub-theme-darkmatter-remix"

```




## 下載ISO檔




## 相關議題

| 相關議題 |
| --- |
| [Create Live Usb Disk for Bios](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-bios.html) |




## 參考文章

* 晚起的蟲 / [開始了解 GPT 並安裝 grub](http://amitmason.blogspot.com/2018/07/gpt.html)
* OsoLinux 快速安裝指南 / [UEFI  Live 啟動盤](https://osolinux.sourceforge.io/doc-1.html)
* G. T. Wang / [Linux 的 Parted 指令教學：建立、變更與修復磁碟分割區](https://blog.gtwang.org/linux/parted-command-to-create-resize-rescue-linux-disk-partitions/)
* Arch Wiki / [Parted](https://wiki.archlinux.org/title/Parted)
* Arch Wiki / [wipefs](https://wiki.archlinux.org/title/Device_file#wipefs)
* Arch Wiki / GRUB / [UEFI systems](https://wiki.archlinux.org/title/GRUB#UEFI_systems)
* Arch Wiki / [EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition)
