---
title: Boot ISO
nav_order: 7030
has_children: true
parent: 如何
---


# Boot ISO




## GRUB Boot ISO 範例

* [GRUB Boot ISO 範例](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/prototype/boot_iso)

| Demo | 修改檔案 | 是否需要執行 update-grub |
| --- | --- | --- |
| [demo_40_custom](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/prototype/boot_iso/demo_40_custom)| [/etc/grub.d/40_custom](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/file/etc_grub_d_40_custom.html) | 修改後，需要執行 `sudo update-grub` |
| [demo_41_custom](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/prototype/boot_iso/demo_41_custom)| [/boot/grub/custom.cfg](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/file/boot_grub_custom_cfg.html) | 修改後，不需要執行 `sudo update-grub` |

| Distro | /etc/grub.d/40_custom | /boot/grub/custom.cfg |
| --- | --- | --- |
| Arch | [/etc/grub.d/40_custom](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_40_custom/ArchLinux/latest/40_custom) | [/boot/grub/custom.cfg](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_41_custom/ArchLinux/latest/custom.cfg) |
| Manjaro | [/etc/grub.d/40_custom](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_40_custom/Manjaro/latest/40_custom) | [/boot/grub/custom.cfg](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_41_custom/Manjaro/latest/custom.cfg) |
| Debian | [/etc/grub.d/40_custom](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_40_custom/Debian/11/40_custom) | [/boot/grub/custom.cfg](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_41_custom/Debian/11/custom.cfg) |
| Ubuntu | [/etc/grub.d/40_custom](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_40_custom/Ubuntu/22.04/40_custom) | [/boot/grub/custom.cfg](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/boot_iso/demo_41_custom/Ubuntu/22.04/custom.cfg) |




## 指引

* [如何自訂 Gurb Menu Entry](https://samwhelp.github.io/note-about-grub/read/start/custom_menu_entry.html)




## GRUB Menu Entry / Boot ISO 樣板 / Arch


``` sh
menuentry "Arch 2022.04.05 ISO" --class Arch {
	set iso_file="/opt/iso/arch/latest/archlinux-2022.04.05-x86_64.iso"
	search --set=iso_partition --no-floppy --file $iso_file
	probe --set=iso_partition_uuid --fs-uuid $iso_partition
	set img_dev="/dev/disk/by-uuid/$iso_partition_uuid"
	loopback loop ($iso_partition)$iso_file
	set boot_option=""
	#set boot_option="quiet splash"
	linux (loop)/arch/boot/x86_64/vmlinuz-linux img_dev=$img_dev img_loop=$iso_file $boot_option
	#initrd (loop)/arch/boot/x86_64/initramfs-linux.img
	initrd (loop)/arch/boot/x86_64/initramfs-linux.img (loop)/arch/boot/intel-ucode.img (loop)/arch/boot/amd-ucode.img
}
```




## GRUB Menu Entry / Boot ISO 樣板 / Manjaro

``` sh
menuentry "Manjaro xfce 21.2.5 ISO" --class Manjaro {
	set iso_file="/opt/iso/manjaro/latest/manjaro-xfce-21.2.5-220314-linux515.iso"
	search --set=iso_partition --no-floppy --file $iso_file
	probe --set=iso_partition_uuid --fs-uuid $iso_partition
	set img_dev="/dev/disk/by-uuid/$iso_partition_uuid"
	loopback loop ($iso_partition)$iso_file
	set boot_option=""
	#set boot_option="lang=zh_TW keytable=us tz=Asia/Taipei"
	#set boot_option="quiet splash"
	linux (loop)/boot/vmlinuz-x86_64 img_dev=$img_dev img_loop=$iso_file $boot_option
	#initrd (loop)/boot/initramfs-x86_64.img
	initrd (loop)/boot/initramfs-x86_64.img (loop)/boot/intel_ucode.img (loop)/boot/amd_ucode.img
}
```




## GRUB Menu Entry / Boot ISO 樣板 / Debian

``` sh
menuentry "Debian 11 Xfce ISO" --class Debian {
	set iso_file="/opt/iso/debian/11/debian-live-11.2.0-amd64-xfce.iso"
	search --set=iso_partition --no-floppy --file $iso_file
	probe --set=iso_partition_uuid --fs-uuid $iso_partition
	set img_dev="/dev/disk/by-uuid/$iso_partition_uuid"
	loopback loop ($iso_partition)$iso_file
	set boot_option=""
	#set boot_option="components splash quiet"
	#set boot_option="components locales=zh_TW.UTF-8 quiet splash"
	linux (loop)/live/vmlinuz-5.10.0-10-amd64 boot=live buuid=$iso_partition_uuid findiso=$iso_file $boot_option
	initrd (loop)/live/initrd.img-5.10.0-10-amd64
}
```




## GRUB Menu Entry / Boot ISO 樣板 / Ubuntu


``` sh
menuentry "Xubuntu 22.04 Live ISO" --class Ubuntu {
	set gfxpayload=keep
	set iso_file="/opt/iso/ubuntu/22.04/xubuntu-22.04-desktop-amd64.iso"
	search --set=iso_partition --no-floppy --file $iso_file
	probe --set=iso_partition_uuid --fs-uuid $iso_partition
	set img_dev="/dev/disk/by-uuid/$iso_partition_uuid"
	loopback loop ($iso_partition)$iso_file
	set boot_option=""
	#set boot_option="locale=zh_TW"
	#set boot_option="quiet splash"
	#set boot_option="file=/cdrom/preseed/xubuntu.seed maybe-ubiquity ---"
	linux (loop)/casper/vmlinuz iso-scan/filename=$iso_file boot=casper $boot_option
	initrd (loop)/casper/initrd
}
```




## GRUB Menu Entry / Boot ISO 樣板 / Fedora

> 請參考「Fedora 探索筆記 / [Boot ISO By GRUB](https://samwhelp.github.io/note-about-fedora/read/core/iso/boot-iso/boot-iso-by-grub.html#grub-menu-entry--boot-iso-%E6%A8%A3%E6%9D%BF--fedora)」




## 參考文章

* [使用 GRUB 以硬碟中的 ISO 映像檔開機](https://blog.gtwang.org/linux/boot-iso-image-from-your-hard-drive-in-ubuntu/)
* [如何從 grub2 啟動 Ubuntu Live CD iso](https://ttys3.dev/post/how-to-boot-ubuntu-live-cd-iso-from-grub2/)




## Reference

* Archcraft Wiki / [Boot Archcraft with GRUB](https://wiki.archcraft.io/docs/boot-iso/boot-with-grub)
* Arch Wiki / [Multiboot USB drive](https://wiki.archlinux.org/title/Multiboot_USB_drive#Configuring_GRUB)
* Arch Wiki / [Kernel parameters](https://wiki.archlinux.org/title/Kernel_parameters#GRUB)
* Ubuntu Community Help Wiki / [Grub2/ISOBoot](https://help.ubuntu.com/community/Grub2/ISOBoot)
* Ubuntu Community Help Wiki / [Grub2/ISOBoot/Examples](https://help.ubuntu.com/community/Grub2/ISOBoot/Examples)




## See Also

* [grml-rescueboot](https://samwhelp.github.io/note-about-grub/read/link/grml-rescueboot.html)
* [ventoy](https://www.ventoy.net/) (GitHub / Ventoy / INSTALL /grub / [grub.cfg](https://github.com/ventoy/Ventoy/blob/master/INSTALL/grub/grub.cfg))
* [grub-iso-boot](https://github.com/Jimmy-Z/grub-iso-boot)
* [glim](https://github.com/thias/glim)
* [multibootusb](https://github.com/aguslr/multibootusb)
