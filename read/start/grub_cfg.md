---
title: /boot/grub/grub.cfg
nav_order: 1010
has_children: false
parent: 入門
---


# /boot/grub/grub.cfg

## Path

* [/boot/grub/grub.cfg](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/file/boot_grub_grub_cfg.html)

## 關於「/boot/grub/grub.cfg」

Grub會根據「/boot/grub/grub.cfg」這個設定檔來運作，

不過在實務上，一般不會直接直接去修改「/boot/grub/grub.cfg」這個檔案。

因為Grub有設計一個機制，

會根據「/etc/default/grub」這個檔案裡面的參數，

以及根據「[/etc/grub.d](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/dir/etc_grub_d.html)」這個資料夾裡面的腳本(Shell Script)，

然後透過「[update-grub](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/command/update-grub.html)」或是「[grub-mkconfig](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/command/grub-mkconfig.html)」這兩個指令，

來產生「/boot/grub/grub.cfg」這個檔案。


## 指令範例


執行
``` sh
sudo update-grub
```

或是執行

``` sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

> 關於「update-grub」這個腳本，裡面也是執行「grub-mkconfig」，請考「[update-grub的探索紀錄](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/command/update-grub.html)」

執行

``` sh
cat $(which update-grub)
```

顯示

```
#!/bin/sh
set -e
exec grub-mkconfig -o /boot/grub/grub.cfg "$@"
```


* $ man [update-grub](http://manpages.ubuntu.com/manpages/focal/en/man8/update-grub.8.html)
* $ man [grub-mkconfig](http://manpages.ubuntu.com/manpages/focal/en/man8/grub-mkconfig.8.html)
* $ info grub -n '[Simple configuration](https://www.gnu.org/software/grub/manual/grub/html_node/Simple-configuration.html)'
* $ info grub -n '[Invoking grub-mkconfig](https://www.gnu.org/software/grub/manual/grub/html_node/Invoking-grub_002dmkconfig.html)'




## 案例

| 案例 |
| --- |
| [Create Live Usb Disk for Uefi](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-uefi.html) |
| [Create Live Usb Disk for Bios](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-bios.html) |




## 接下來

接下來，來了解「[/etc/default/grub](https://samwhelp.github.io/note-about-grub/read/start/etc_default_grub.html)」這個檔案的用處。
