---
title: Create Live Usb Disk for Uefi
nav_order: 7031
has_children: false
parent: Boot ISO
grand_parent: 如何
---


# Create Live Usb Disk for Uefi




## 主題

* [緣起](#緣起)
* [操作環境](#操作環境)
* [操作背景](#操作背景)
* [相關議題](#相關議題)
* [參考文章](#參考文章)




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

有兩種版本，本篇是「UEFI版」，另一篇是「[BIOS版](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-bios.html)」。




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




## 相關議題

| 相關議題 |
| --- |
| [Create Live Usb Disk for Bios](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-bios.html) |




## 參考文章

* 晚起的蟲 / [開始了解 GPT 並安裝 grub](http://amitmason.blogspot.com/2018/07/gpt.html)
* OsoLinux 快速安裝指南 / [UEFI  Live 啟動盤](https://osolinux.sourceforge.io/doc-1.html)
* G. T. Wang / [Linux 的 Parted 指令教學：建立、變更與修復磁碟分割區](https://blog.gtwang.org/linux/parted-command-to-create-resize-rescue-linux-disk-partitions/)
