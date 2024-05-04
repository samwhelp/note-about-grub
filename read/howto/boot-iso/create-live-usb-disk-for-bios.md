---
title: Create Live Usb Disk for Bios
nav_order: 7032
has_children: false
parent: Boot ISO
grand_parent: 如何
---


# Create Live Usb Disk for Bios




## 主題

* [完整腳本範例](#完整腳本範例)
* [承起](#承起)
* [硬碟分割規格](#硬碟分割規格)
* [硬碟分割操作](#硬碟分割操作)
* [掛載分割區](#掛載分割區)
* [grub-install](#grub-install)
* [產生「/boot/grub/grub.cfg」](#產生bootgrubgrubcfg)
* [grub-theme](#grub-theme)
* [下載ISO檔](#下載iso檔)
* [相關議題](#相關議題)
* [參考文章](#參考文章)




## 完整腳本範例

| 範例 |
| --- |
| [demo-create-live-usb-disk-for-bios-start](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-usb-disk/bios/demo-create-live-usb-disk-for-bios-start/prototype) |




## 承起

承起「[Create Live Usb Disk for Uefi](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-uefi.html)」該篇提到的概念，

這篇要會回過頭來紀錄「BIOS版」的操作步驟。



## 硬碟分割規格

| Type | Device ID | File System | Flags       | 用途                          |
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

若是要觀看「/dev/sdc2」的一些「Lable」或「UUID」，可以執行下面指令

``` sh
sudo blkid /dev/sdc2
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

執行下面指令，將「/dev/sdc2」掛載到「mnt」。

``` sh
sudo mount /dev/sdc2 ./mnt
```


> 卸載的參考指令

假設「mnt」這個資料夾有掛載分割區，執行下面指令，卸載「mnt」這個資料夾所掛載分割區。

``` sh
sudo umount ./mnt
```

假設「/dev/sdc2」有被掛載，執行下面指令，卸載「/dev/sdc2」。

``` sh
sudo umount /dev/sdc2
```

或是執行下面指令，確保「/dev/sdc*」都被卸載。

``` sh
sudo umount /dev/sdc*
```




## grub-install

執行

``` sh

sudo grub-install \
	--boot-directory="mnt/boot" \
	--target="i386-pc" \
	--fonts="unicode" \
	/dev/sdc

```




## 產生「/boot/grub/grub.cfg」

產生「/boot/grub/grub.cfg」這個關鍵的設定檔，內容類似如下

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




insmod part_gpt
insmod ext2


##
## ## Set root
##

search --no-floppy --fs-uuid --set=root df327def-4e94-4b5e-b7d9-d17b8323571d




##
## ## Locale
##

loadfont ($root)/boot/grub/fonts/unicode.pf2
set locale_dir=($root)/boot/grub/locale
set lang=zh_TW




##
## Resolution
##

set gfxmode=auto
terminal_output gfxterm




##
## ## Theme
##

background_image ($root)/boot/grub/themes/grub-theme-obs-remix/background.jpg
set theme=($root)/boot/grub/themes/grub-theme-obs-remix/theme.txt
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


menuentry "Fedora 40 ISO / Kde Plasma" {
	set iso_file=/iso/Fedora-KDE-Live-x86_64-40_Beta-1.10.iso
	loopback loop $iso_file
	linux (loop)/images/pxeboot/vmlinuz iso-scan/filename=$iso_file root=live:CDLABEL=Fedora-KDE-Live-40-1-14 rd.live.image rhgb $boot_option
	initrd (loop)/images/pxeboot/initrd.img
}

```

上面其中有一行設定如下

``` sh
search --no-floppy --fs-uuid --set=root df327def-4e94-4b5e-b7d9-d17b8323571d
```

記得要將「`df327def-4e94-4b5e-b7d9-d17b8323571d`」改成您當下「/dev/sdc2」的「UUID」


可以執行下面指令，獲得「/dev/sdc2」的「UUID」。

``` sh
sudo blkid /dev/sdc2 | sed 's|\ |\n|g' | grep '^UUID=' | awk -F '"' '{print$2}'
````



## grub-theme

``` sh
set theme=($root)/EFI/grub/themes/grub-theme-obs-remix/theme.txt
```

上面的設定，我是採用「[grub-theme-obs-remix](https://github.com/samwhelp/grub-theme-obs-remix)」。


所以執行下面的指令，下載下來，並且解壓縮，放置到「mnt/EFI/grub/themes/grub-theme-obs-remix」這個路徑。

``` sh

mkdir -p "./tmp"


wget -c "https://github.com/samwhelp/grub-theme-obs-remix/archive/refs/heads/main.tar.gz" -O "./tmp/grub-theme-obs-remix-main.tar.gz"

tar xf "./tmp/grub-theme-obs-remix-main.tar.gz" -C "./tmp"


sudo mkdir -p "mnt/boot/grub/themes"

sudo cp -rf "tmp/grub-theme-obs-remix-main/." "mnt/boot/grub/themes/grub-theme-obs-remix"

```




## 下載ISO檔






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
