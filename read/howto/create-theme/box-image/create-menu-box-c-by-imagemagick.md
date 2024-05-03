---
title: 產生 menu-box-c.png
nav_order: 7051
has_children: false
parent: Create Theme
grand_parent: 如何
---


# 產生 menu-box-c.png




## 主題

* [完整腳本範例](#完整腳本範例)
* [前提](#前提)
* [操作環境](#操作環境)
* [前置作業](#前置作業)
* [操作步驟](#操作步驟)
* [參考文章](#參考文章)




## 完整腳本範例

| 範例 |
| --- |
| [demo-create-menu-box-c](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-theme-image/demo-create-menu-box-c) |





## 前提

從「Grub Docs / Theme file format / [7.2.7 Styled Boxes](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html)」，

可以了解到，GRUB選單畫面的一些元素，是採用「九宮圖」。

我將「[monterey-grub-theme](https://github.com/sandesh236/monterey-grub-theme) ([pling](https://www.pling.com/p/1577873))」這個專案，

做了「重構」產生一個新的專案「[grub-theme-monterey-refactoring](https://github.com/samwhelp/grub-theme-monterey-refactoring)」。

其中我們可以看到「GRUB選單畫面」那個「圓角方框(圓角矩形)」中間的圖是「[menu-box-c.png](https://github.com/samwhelp/grub-theme-monterey-refactoring/blob/main/asset/menu-box/menu-box-c.png)」是「白色透明的」，


我另外產生一個新的專案「[grub-theme-monterey-remix](https://github.com/samwhelp/grub-theme-monterey-remix)」

要將「[menu-box-c.png](https://github.com/samwhelp/grub-theme-monterey-remix/blob/main/asset/menu-box/menu-box-c.png)」改成「黑色透明」，


此篇是透過「[ImageMagick](https://imagemagick.org/index.php)」這個工具來產生這張圖，用來當作學習「製作 menu box 九宮圖」的起點




## 操作環境

* Lubuntu `24.04`
* imagemagick `6.9.12-98`




## 前置作業

執行下面指令，安裝「[imagemagick](https://packages.ubuntu.com/noble/imagemagick)」

``` sh
sudo apt-get install imagemagick
```

安裝完成後，執行下面指令，觀看版本

``` sh
convert --version
```

顯示

```
Version: ImageMagick 6.9.12-98 Q16 x86_64 18038 https://legacy.imagemagick.org
Copyright: (C) 1999 ImageMagick Studio LLC
License: https://imagemagick.org/script/license.php
Features: Cipher DPC Modules OpenMP(4.5)
Delegates (built-in): bzlib djvu fftw fontconfig freetype heic jbig jng jp2 jpeg lcms lqr ltdl lzma openexr pangocairo png raw tiff webp wmf x xml zlib
```




## 操作步驟

執行下面[指令](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/howto/demo-create-theme-image/demo-create-menu-box-c/create.sh#L9)，產生「[menu-box-c.png](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/howto/demo-create-theme-image/demo-create-menu-box-c/menu-box-c.png)」。

``` sh
convert -size 10x10 'canvas:rgba(0,0,0,0.7)' 'PNG32:menu-box-c.png'
```

上面的指令，表示要產生一張「10x10」的圖，

檔案名稱是「`menu-box-c.png`」。

這張圖只有單純的「畫布(canvas)」，

畫布顏色是「黑色透明」，也就是「`rgba(0,0,0,0.7)`」。




## 參考文章

| 參考文章 |
| ------- |
| [https://imagemagick.org/Usage/canvas/](https://imagemagick.org/Usage/canvas/) |
| [https://imagemagick.org/Usage/files/](https://imagemagick.org/Usage/files/) |
| [https://imagemagick.org/Usage/formats/](https://imagemagick.org/Usage/formats/) |
| [https://www.imagemagick.org/script/color.php](https://www.imagemagick.org/script/color.php) |
| [https://www.imagemagick.org/script/formats.php](https://www.imagemagick.org/script/formats.php) |
| [https://www.imagemagick.org/discourse-server/viewtopic.php?t=24060](https://www.imagemagick.org/discourse-server/viewtopic.php?t=24060) |
| [https://www.imagemagick.org/discourse-server/viewtopic.php?t=18300](https://www.imagemagick.org/discourse-server/viewtopic.php?t=18300) |
