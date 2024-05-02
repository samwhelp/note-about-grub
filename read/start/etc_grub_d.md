---
title: /etc/grub.d/
nav_order: 1030
has_children: false
parent: 入門
---


# /etc/grub.d/

## Path

* [/etc/grub.d/](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/dir/etc_grub_d.html)

## 關於「/etc/grub.d/」

延續「[之前](https://samwhelp.github.io/note-about-grub/read/start/grub_cfg.html)」提到的，

在「[/etc/grub.d/](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/dir/etc_grub_d.html)」裡面有放置很多「執行腳本(Shell Script)」。

執行下面指令，觀看「/etc/grub.d/」這個資料夾，有哪些檔案

``` sh
ls /etc/grub.d -1
```

顯示

```
00_header
05_debian_theme
10_linux
10_linux_zfs
20_linux_xen
20_memtest86+
30_os-prober
30_uefi-firmware
40_custom
41_custom
README
```

執行下面指令，觀看「README」

```

All executable files in this directory are processed in shell expansion order.

  00_*: Reserved for 00_header.
  10_*: Native boot entries.
  20_*: Third party apps (e.g. memtest86+).

The number namespace in-between is configurable by system installer and/or
administrator.  For example, you can add an entry to boot another OS as
01_otheros, 11_otheros, etc, depending on the position you want it to occupy in
the menu; and then adjust the default setting via /etc/default/grub.

```

## 相關連結

* Ubuntu Package / grub-common / [filelist](https://packages.ubuntu.com/focal/amd64/grub-common/filelist)
* launchpad / grub / util / [grub.d](https://git.launchpad.net/~ubuntu-core-dev/grub/+git/ubuntu/tree/util/grub.d)
* savannah / grub / util / [grub.d](https://git.savannah.gnu.org/cgit/grub.git/tree/util/grub.d)


## 接下來

接下來，來探討「/etc/grub.d/」這裡面的腳本，

先從「[/etc/grub.d/40_custom](https://samwhelp.github.io/note-about-grub/read/start/40_custom.html)」來探索「[如何自訂 Gurb Menu Entry](https://samwhelp.github.io/note-about-grub/read/start/custom_menu_entry.html)」。
