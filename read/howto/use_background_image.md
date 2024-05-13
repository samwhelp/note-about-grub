---
title: Use Background Image
nav_order: 7020
has_children: false
parent: 如何
---


# Use Background Image




## 主題

* [說明](#說明)
* [案例](#案例)
* [參考文件](#參考文件)




## 說明

延續「[Use Theme](https://samwhelp.github.io/note-about-grub/read/howto/use_theme.html)」這篇提到的。

若是在「`/etc/default/grub`」這個檔案，

如果我們沒有設定「`GRUB_THEME`」這個參數，

我們也可以單獨設定「`GRUB_BACKGROUND`」這個參數，

這樣就是單純的設定背景圖。

在大部分的系統，「`GRUB_THEME`」和「`GRUB_BACKGROUND`」同時設定時，

只有「`GRUB_THEME`」有作用。

但是在「[Debian](https://packages.debian.org/bookworm/amd64/grub-common/filelist)」或是「[Ubuntu](https://packages.ubuntu.com/noble/amd64/grub-common/filelist)」系列的系統，

因為有附帶「[/etc/grub.d/05_debian_theme](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/prototype/grub-config/grub-helper/grub-mkconfig-helper/asset/overlay/etc/grub.d/05_debian_theme)」這個「`grub-mkconfig helper script`」，

所以「`GRUB_THEME`」和「`GRUB_BACKGROUND`」同時設定時，是可以同時有作用的。

> 關於「`GRUB_THEME`」，是「設定採用的佈景主題」，該佈景主題的「[theme.txt](https://github.com/samwhelp/grub-theme-glass-remix/blob/main/theme.txt#L3)」會指定「背景圖」，這個「背景圖」會在「GRUB 載入選單畫面」顯示。

> 關於「`GRUB_BACKGROUND`」，指定的「背景圖」，則是會在「GRUB Teminal」狀態下顯示。




## 案例


| 案例 |
| --- |
| [grub-theme-refactoring](https://samwhelp.github.io/grub-theme-refactoring/) |
| [grub-theme-remix](https://samwhelp.github.io/grub-theme-remix/) |




## Grub Theme / Glass Series

| Base | Remix |
| ---- | ----- |
| [grub-theme-score](https://github.com/samwhelp/grub-theme-score) | [grub-theme-score-remix](https://github.com/samwhelp/grub-theme-score-remix) |
| [grub-theme-glass](https://github.com/samwhelp/grub-theme-glass) | [grub-theme-glass-remix](https://github.com/samwhelp/grub-theme-glass-remix) |
| [grub-theme-cover](https://github.com/samwhelp/grub-theme-cover) | [grub-theme-cover-remix](https://github.com/samwhelp/grub-theme-cover-remix) |
| [grub-theme-banner](https://github.com/samwhelp/grub-theme-banner) | [grub-theme-banner-remix](https://github.com/samwhelp/grub-theme-banner-remix) |
| [grub-theme-cross](https://github.com/samwhelp/grub-theme-cross) | [grub-theme-cross-remix](https://github.com/samwhelp/grub-theme-cross-remix) |




## 參考文件

| 參考文件 | 線上閱讀 |
| ------- | ------- |
| $ `info grub -n 'Simple configuration'` | [6.1 Simple configuration handling](https://www.gnu.org/software/grub/manual/grub/html_node/Simple-configuration.html) |
| $ `info grub -n 'background_image'` | [16.3.5 background_image](https://www.gnu.org/software/grub/manual/grub/html_node/background_005fimage.html#background_005fimage) |
| $ `info grub -n 'theme'` | [15.1.46 theme](https://www.gnu.org/software/grub/manual/grub/html_node/theme.html#theme) |
| $ `info grub -n 'Theme file format'` | [7 Theme file format](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html#Global-Properties) |




## 以前的探索

* [以前的探索](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/draft/use_background_image.md)




## 相關案例

| 議題 | 簡介 |
| --- | --- |
| [Create Live Usb Disk for Uefi](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-uefi.html#%E7%94%A2%E7%94%9Fefigrubgrubcfg) | 產生單獨透過GRUB和ISO檔開機的「USB Disk」/ 「UEFI 版」 |
| [Create Live Usb Disk for Bios](https://samwhelp.github.io/note-about-grub/read/howto/boot-iso/create-live-usb-disk-for-bios.html#%E7%94%A2%E7%94%9Fbootgrubgrubcfg) | 產生單獨透過GRUB和ISO檔開機的「USB Disk」/ 「BIOS 版」 |
