---
title: 產生 menu-box 九宮圖
nav_order: 7052
has_children: false
parent: Create Theme
grand_parent: 如何
---


# 產生 menu-box 九宮圖




## 主題

* [完整腳本範例](#完整腳本範例)
* [承接](#承接)
* [九宮圖代號](#九宮圖代號)
* [操作步驟](#操作步驟)
* [參考文章](#參考文章)
* [Docs](#docs)






## 完整腳本範例

| 範例 |
| --- |
| [demo-create-menu-box-rounded-rectangle-dark](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-theme-image/demo-create-menu-box-rounded-rectangle-dark) |
| [demo-create-menu-box-rounded-rectangle-light](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-theme-image/demo-create-menu-box-rounded-rectangle-light) |
| [demo-create-terminal-box-rounded-rectangle-dark](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-theme-image/demo-create-terminal-box-rounded-rectangle-dark) |
| [demo-create-terminal-box-rounded-rectangle-light](https://github.com/samwhelp/note-about-grub/tree/gh-pages/_demo/howto/demo-create-theme-image/demo-create-terminal-box-rounded-rectangle-light) |




## 承接

接續「[產生 menu-box-c.png](https://samwhelp.github.io/note-about-grub/read/howto/create-theme/box-image/create-menu-box-c-by-imagemagick.html)」這篇學習的起點，

這篇要來介紹『**如何透過「ImageMagick」製作簡易「圓角矩形」的「九宮圖」**』。




## 九宮圖代號

| Region              | Region          | Region              |
| ------------------- | --------------- | ------------------- |
| 1. Northwest (`nw`) | 2. North (`n`)  | 3. Northeast (`ne`) |
| 4. West (`w`)       | 5. Center (`c`) | 6. East (`e`)       |
| 7. Southwest (`sw`) | 8. South (`s`)  | 9. Southeast (`se`) |

對應「menu box」的「圖檔名稱」如下

| Region               | Region              | Region               |
| -------------------- | ------------------- | -------------------- |
| 1. `menu-box-nw.png` | 2. `menu-box-n.png` | 3. `menu-box-ne.png` |
| 4. `menu-box-w.png`  | 5. `menu-box-c.png` | 6. `menu-box-e.png`  |
| 7. `menu-box-sw.png` | 8. `menu-box-s.png` | 9. `menu-box-se.png` |




## 操作步驟


執行下面指令，先產生一張「圓角矩形」的「資源圖」，名稱是「[mask.png](https://github.com/samwhelp/note-about-grub/blob/gh-pages/_demo/howto/demo-create-theme-image/demo-create-menu-box-rounded-rectangle-dark/mask.png)」。

``` sh

convert \
	-size 200x200 'canvas:rgba(0,0,0,0)' \
	-fill 'rgba(0,0,0,0.7)' -draw "roundrectangle 0,0,200,200,16,16"  \
	mask.png

```


執行下面指令，從「mask.png」擷取「四方的圓角」，圖片大小是「20x20」。

``` sh
convert mask.png -crop '20x20+0+0' 'PNG32:menu-box-nw.png'

convert mask.png -crop '20x20+180+0' 'PNG32:menu-box-ne.png'


convert mask.png -crop '20x20+0+180' 'PNG32:menu-box-sw.png'

convert mask.png -crop '20x20+180+180' 'PNG32:menu-box-se.png'

```


執行下面指令，產生「除了四方圓角」的區域，圖片大小是「20x20」。


``` sh

convert -size 20x20 'canvas:rgba(0,0,0,0.7)' 'PNG32:menu-box-n.png'


convert -size 20x20 'canvas:rgba(0,0,0,0.7)' 'PNG32:menu-box-e.png'

convert -size 20x20 'canvas:rgba(0,0,0,0.7)' 'PNG32:menu-box-c.png'

convert -size 20x20 'canvas:rgba(0,0,0,0.7)' 'PNG32:menu-box-w.png'


convert -size 20x20 'canvas:rgba(0,0,0,0.7)' 'PNG32:menu-box-s.png'

```


## 參考文章

| 參考文章 |
| ------- |
| [https://legacy.imagemagick.org/Usage/draw/](https://legacy.imagemagick.org/Usage/draw/) |
| [https://legacy.imagemagick.org/Usage/thumbnails/#rounded](https://legacy.imagemagick.org/Usage/thumbnails/#rounded) |
| [https://stackoverflow.com/questions/718314/rounding-corners-of-pictures-with-imagemagick](https://stackoverflow.com/questions/718314/rounding-corners-of-pictures-with-imagemagick) |




## Docs

| Docs |
| --- |
| [Grub2 theme tutorial](http://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial) |
| [Grub2 theme reference](http://wiki.rosalab.ru/en/index.php/Grub2_theme_/_reference) |
| [Theme file format](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html) |
