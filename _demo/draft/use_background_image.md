---
title: Use Background Image
nav_order: 7020
has_children: false
parent: 如何
---


# Use Background Image




## 主題

* [案例](#案例)
* [參考文件](#參考文件)
* [放置路徑](#放置路徑)
* [下載背景圖片](#下載背景圖片)
* [設定採用](#設定採用)
* [深入探索](#深入探索)




## 案例

| 案例 |
| --- |
| [grub-theme-refactoring](https://samwhelp.github.io/grub-theme-refactoring/) |
| [grub-theme-remix](https://samwhelp.github.io/grub-theme-remix/) |




## 參考文件

| 參考文件 | 線上閱讀 |
| ------- | ------- |
| $ `info grub -n 'Simple configuration'` | [6.1 Simple configuration handling](https://www.gnu.org/software/grub/manual/grub/html_node/Simple-configuration.html) |
| $ `info grub -n 'background_image'` | [16.3.5 background_image](https://www.gnu.org/software/grub/manual/grub/html_node/background_005fimage.html#background_005fimage) |
| $ `info grub -n 'theme'` | [15.1.46 theme](https://www.gnu.org/software/grub/manual/grub/html_node/theme.html#theme) |
| $ `info grub -n 'Theme file format'` | [7 Theme file format](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html#Global-Properties) |




## 放置路徑

* /boot/grub/backgrounds/

> 上面的放置路徑是舉例，其他路徑基本上也可以，不限定放在上面的路徑

執行下面指令，產生「/boot/grub/backgrounds」這個資料夾

``` sh
sudo mkdir -p /boot/grub/backgrounds
```

## 下載背景圖片

執行下面指令，產生「~/Downloads/grub_background_image」這個資料夾

``` sh
mkdir -p ~/Downloads/grub_background_image
```

執行下面指令，切換到「~/Downloads/grub_background_image」這個資料夾

``` sh
cd ~/Downloads/grub_background_image
```

執行下面指令，下載「[ubuntu-2.png](https://github.com/dracula/wallpaper/blob/master/ubuntu-2.png)」這張[圖片](https://raw.githubusercontent.com/dracula/wallpaper/master/ubuntu-2.png)。

``` sh
wget -c 'https://raw.githubusercontent.com/dracula/wallpaper/master/ubuntu-2.png'
```

執行下面指令，複製上面的圖片到「/boot/grub/backgrounds」這個資料夾。

``` sh
sudo cp ubuntu-2.png /boot/grub/backgrounds/console-background.png
```

並且改名為「console-background.png」，

也就是「/boot/grub/backgrounds/console-background.png」。

這個名稱只是舉例，並沒有限定什麼名稱。


## 設定採用

接著來說明，如何設定「GRUB」採用某個「背景圖片」

主要是編輯「/etc/default/grub」這個檔案

``` sh
sudo vi /etc/default/grub
```

加入下面這一行

```
GRUB_BACKGROUND="/boot/grub/backgrounds/console-background.png"
```

接著執行下面指令，更新「grub的設定」

``` sh
sudo update-grub
```

若沒有「update-grub」這個指令，可以改採下面的指令

``` sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

會顯示類似下面的提示訊息

```
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found background: /boot/grub/backgrounds/console-background.png
Found background image: /boot/grub/backgrounds/console-background.png
...略...
```

接著重開機，就會看到「grub」的「boot menu」和「console」都會有背景圖片

> 在「boot menu」畫面，按下「e」或「c」都會進到「grub console mode」。

> 按下「Enter」除了選擇某個選項開機，也會進到「grub console mode」。

> 也可以產生一個檔案「/etc/default/grub.d/background.cfg」來設定「GRUB_BACKGROUND="/boot/grub/backgrounds/console-background.png"」。


## 深入探索


### 探索「/etc/grub.d/」

執行

``` sh
grep 'Found background' /etc/grub.d/* -R
```

顯示

```
/etc/grub.d/00_header:	gettext_printf "Found background: %s\n" "$GRUB_BACKGROUND" >&2
/etc/grub.d/05_debian_theme:	echo "Found background image: ${1}" >&2
```

> 可以了解到「下面這個訊息」，是來自於「/etc/grub.d/00_header」這個檔案。

```
Found background: /boot/grub/backgrounds/console-background.png
```

> 可以了解到「下面這個訊息」，是來自於「/etc/grub.d/05_debian_theme」這個檔案。

```
Found background image: /boot/grub/backgrounds/console-background.png
```




執行

``` sh
grep 'GRUB_BACKGROUND' /etc/grub.d/* -R
```

顯示

```
/etc/grub.d/00_header:    elif [ "x$GRUB_BACKGROUND" != x ] && [ -f "$GRUB_BACKGROUND" ] \
/etc/grub.d/00_header:	    && is_path_readable_by_grub "$GRUB_BACKGROUND"; then
/etc/grub.d/00_header:	gettext_printf "Found background: %s\n" "$GRUB_BACKGROUND" >&2
/etc/grub.d/00_header:	case "$GRUB_BACKGROUND" in
/etc/grub.d/00_header:	prepare_grub_to_access_device `${grub_probe} --target=device "$GRUB_BACKGROUND"`
/etc/grub.d/00_header:background_image -m stretch `make_system_path_relative_to_its_root "$GRUB_BACKGROUND"`
/etc/grub.d/05_debian_theme:if [ -n "${GRUB_BACKGROUND+x}" ]; then
/etc/grub.d/05_debian_theme:	set_background_image "${GRUB_BACKGROUND}" || set_default_theme
```


### 探索「/boot/grub/grub.cfg」

執行

``` sh
grep '/boot/grub/backgrounds/console-background.png' /boot/grub/grub.cfg -R -n
```

顯示

```
116:background_image -m stretch /boot/grub/backgrounds/console-background.png
141:if background_image /boot/grub/backgrounds/console-background.png; then
```

> 會發現到「GRUB_BACKGROUND」這個「參數」的設定，是會被轉譯成「background_image」的「grub 指令」。

* $ `info grub -n 'Simple configuration'` ## [6.1 Simple configuration handling](https://www.gnu.org/software/grub/manual/grub/html_node/Simple-configuration.html)

> 可以從上面的文件，找到「GRUB_BACKGROUND」這個「參數」的說明

* $ `info grub -n 'background_image'` ## [16.3.5 background_image](https://www.gnu.org/software/grub/manual/grub/html_node/background_005fimage.html#background_005fimage)

> 可以從上面的文件，找到「background_image」這個「grub 指令」的說明


### /etc/grub.d/00_header

執行

``` sh
grep '### BEGIN /etc/grub.d/00_header ###' /boot/grub/grub.cfg -R -A 122 | less
```

會顯示一段程式碼片段，因為很長，就不貼上來。


### /etc/grub.d/05_debian_theme

接著執行

``` sh
grep '### BEGIN /etc/grub.d/05_debian_theme ###' /boot/grub/grub.cfg -R -A 16
```

顯示

``` sh
### BEGIN /etc/grub.d/05_debian_theme ###
insmod part_gpt
insmod ext2
set root='hd1,gpt3'
if [ x$feature_platform_search_hint = xy ]; then
  search --no-floppy --fs-uuid --set=root --hint-bios=hd1,gpt3 --hint-efi=hd1,gpt3 --hint-baremetal=ahci1,gpt3  16deb60a-ad54-4ae5-885e-022debc0145e
else
  search --no-floppy --fs-uuid --set=root 16deb60a-ad54-4ae5-885e-022debc0145e
fi
insmod png
if background_image /boot/grub/backgrounds/console-background.png; then
  true
else
  set menu_color_normal=white/black
  set menu_color_highlight=black/light-gray
fi
### END /etc/grub.d/05_debian_theme ###
```

上面這段「/boot/grub/grub.cfg」的程式碼片段，

是執行過「sudo update-grub」，

其中由「/etc/grub.d/05_debian_theme」所產出的。


## 同時設定「GRUB_BACKGROUND」和「GRUB_THEME」


## 下載佈景主題

執行下面指令，產生「~/Downloads/grub_theme」這個資料夾

``` sh
mkdir -p ~/Downloads/grub_theme
```

執行下面指令，切換到「~/Downloads/grub_theme」這個資料夾

``` sh
cd ~/Downloads/grub_theme
```

執行下面指令，clone「[poly-dark](https://github.com/shvchk/poly-dark)」這個「GRUB 佈景主題」。

``` sh
git clone 'https://github.com/shvchk/poly-dark.git'
```

執行下面指令，產生「/boot/grub/themes/poly-dark」這個資料夾

``` sh
sudo mkdir -p /boot/grub/themes/poly-dark
```

執行下面指令，複製上面的「GRUB 佈景主題」到「/boot/grub/themes/poly-dark/」這個資料夾。

``` sh
sudo cp -rf poly-dark/. /boot/grub/themes/poly-dark
```


編輯「/etc/default/grub」這個檔案

``` sh
sudo vi /etc/default/grub
```

加入下面這兩行，同時設定「GRUB_BACKGROUND」和「GRUB_THEME」這兩個「參數」。

```
GRUB_BACKGROUND="/boot/grub/backgrounds/console-background.png"
GRUB_THEME="/boot/grub/themes/poly-dark/theme.txt"
```

接著執行下面指令，更新「grub的設定」

``` sh
sudo update-grub
```


會顯示類似下面的提示訊息

```
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found theme: /boot/grub/themes/poly-dark/theme.txt
Found background image: /boot/grub/backgrounds/console-background.png
...略...
```

你會發現到，只剩下

```
Found background image: /boot/grub/backgrounds/console-background.png
```

而「Found background: /boot/grub/backgrounds/console-background.png」這個訊息不見了

由此推論「/etc/grub.d/00_header」裡面的演算法

只會根據「GRUB_BACKGROUND」或「GRUB_THEME」其中一個設定。

接下來重新開機

可以發現到

> 在「console」的「背景圖片」是「/boot/grub/backgrounds/console-background.png」。

> 在「boot menu」的「背景圖片」則是「/boot/grub/themes/poly-dark/background.png」。

> 而「/boot/grub/themes/poly-dark/background.png」這張圖是在「/boot/grub/themes/poly-dark/theme.txt」設定的。

執行

``` sh
grep 'desktop-image' /boot/grub/themes/poly-dark/theme.txt
```

顯示

```
desktop-image: "background.png"
```

執行

``` sh
file /boot/grub/themes/poly-dark/background.png
```

顯示

```
/boot/grub/themes/poly-dark/background.png: PNG image data, 1920 x 1080, 8-bit grayscale, non-interlaced
```

執行下面指令，觀看「/boot/grub/themes/poly-dark/background.png」這張圖片

``` sh
viewnior /boot/grub/themes/poly-dark/background.png
```

> 關於「desktop-image」，可以從下面文件找到相關說明。

* $ `info grub -n 'Theme file format'` ## [7 Theme file format](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html#Global-Properties)


## 再次探索

執行

``` sh
grep '/boot/grub/themes/poly-dark/theme.txt' /boot/grub/grub.cfg
```

顯示

```
set theme=($root)/boot/grub/themes/poly-dark/theme.txt
```

> 可以了解到

> 在「/etc/default/grub」設定「GRUB_THEME="/boot/grub/themes/poly-dark/theme.txt"」

> 在「/boot/grub/grub.cfg」，會被轉譯成「set theme=($root)/boot/grub/themes/poly-dark/theme.txt」


## 設定「console」畫面大小

編輯「[/boot/grub/themes/poly-dark/theme.txt]()」

``` sh
sudo vi /boot/grub/themes/poly-dark/theme.txt
```

將原本的

```
terminal-left: "0"
terminal-top: "0"
terminal-width: "100%"
terminal-height: "100%"
terminal-border: "0"
```

改成如下

```
terminal-left: "10%"
terminal-top: "10%"
terminal-width: "80%"
terminal-height: "80%"
terminal-border: "0"
```

接著重新開機，按下「e」或「c」進到「console mode」，

發現「console mode」不再是全螢幕，而是略微縮小，顯示在畫面中間。

而且可以同時看到「boot menu」的背景圖片，和「console」的背景圖片。


> 關於「terminal-」開頭的這幾個「theme.txt 參數」，可以從下面文件找到相關說明。

* $ `info grub -n 'Theme file format'` ## [7 Theme file format](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html#Global-Properties)


## 設定同個背景圖片

我們也可以設定「boot menu」和「console」是同一個背景圖片。

編輯「/etc/default/grub」這個檔案

``` sh
sudo vi /etc/default/grub
```

加入下面這兩行，同時設定「GRUB_BACKGROUND」和「GRUB_THEME」這兩個「參數」。

這樣「boot menu」和「console」是同一個背景圖片「/boot/grub/themes/poly-dark/background.png」。

```
GRUB_BACKGROUND="/boot/grub/themes/poly-dark/background.png"
GRUB_THEME="/boot/grub/themes/poly-dark/theme.txt"
```

接著執行下面指令，更新「grub的設定」

``` sh
sudo update-grub
```


會顯示類似下面的提示訊息

```
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found theme: /boot/grub/themes/poly-dark/theme.txt
Found background image: /boot/grub/themes/poly-dark/background.png
...略...
```

接著重新開機，

在「boot menu」畫面，按下「e」或「c」進到「console mode」看看是否是同個圖片。

按下「Esc」從「console mode」回到「boot menu」。
