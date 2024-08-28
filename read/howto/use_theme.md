---
title: Use Theme
nav_order: 7010
has_children: false
parent: 如何
---


# Use Theme




## 主題

* [案例](#案例)
* [放置路徑](#放置路徑)
* [手動安裝](#手動安裝)
* [設定採用](#設定採用)
* [輔助工具](#輔助工具)
* [預覽工具](#預覽工具)
* [接下來](#接下來)




## 案例

| 案例 |
| --- |
| [grub-theme-refactoring](https://samwhelp.github.io/grub-theme-refactoring/) |
| [grub-theme-remix](https://samwhelp.github.io/grub-theme-remix/) |




## 放置路徑

| 放置路徑 |
| ---- |
| /usr/share/grub/themes/ |
| /boot/grub/themes/ |

> 上面兩個放置路徑都可以，其他路徑基本上也可以，不限定在上面兩個路徑




## 如何安裝

安裝新的「Grub Theme(佈景主題)」，有兩個方式，一種是「手動安裝」，一種是「套件包安裝」。

以下採用「手動安裝」來說明。




## 手動安裝

可以到這個「[網站](https://www.gnome-look.org/browse?cat=109&ord=latest)」找尋個人偏愛的「GRUB佈景主題」。

以下以安裝「[Dracula](https://github.com/zshzero/dracula-grub2/)」這個「GRUB 佈景主題」為例，

執行下面指令，產生「`/boot/grub/themes`」這個資料夾。

``` sh
sudo mkdir -p /boot/grub/themes
```

執行下面指令，產生「~/Downloads/download_grub_theme」這個資料夾。

``` sh
mkdir -p ~/Downloads/download_grub_theme
```

執行下面指令，切換到「~/Downloads/download_grub_theme」這個路徑。

``` sh
cd ~/Downloads/download_grub_theme
```

執行下面指令，clone「[Dracula](https://github.com/zshzero/dracula-grub2/)」這個「GRUB 佈景主題」。

``` sh
git clone https://github.com/zshzero/dracula-grub2.git dracula
```

執行下面指令，複製到「/boot/grub/themes/dracula」這個路徑

``` sh
sudo cp -rf dracula/. /boot/grub/themes/dracula
```

以上步驟，就已經安裝完成了。

接著要執行「[設定採用](#設定採用)」的步驟。

>　關於「`dracula/.`」，後面多後面多加了「`/.`」，這樣在複製的時候，可以確保「/boot/grub/themes/dracula」這個資料夾已經存在時，複製過去，會直接覆蓋。


請確保「佈景主題」裡，有「theme.txt」這個檔案，

也就是「`/boot/grub/themes/dracula/theme.txt`」這個檔案

執行

``` sh
file /boot/grub/themes/dracula/theme.txt
```

顯示

```
/boot/grub/themes/dracula/theme.txt: ASCII text
```

執行下面指令，顯示「/boot/grub/themes/dracula」裡的資料夾結構

``` sh
tree /boot/grub/themes/dracula
```

顯示

```
/boot/grub/themes/dracula
├── background.png
├── box_c.png
├── box_selected_c.png
├── box_terminal_c.png
├── icons
│   ├── antergos.png
│   ├── arch.png
│   ├── chakra.png
│   ├── crunchbang.png
│   ├── debian.png
│   ├── deepin.png
│   ├── edubuntu.png
│   ├── elementary.png
│   ├── fedora.png
│   ├── frugalware.png
│   ├── gentoo.png
│   ├── gnu-linux.png
│   ├── kali.png
│   ├── kaos.png
│   ├── korora.png
│   ├── kubuntu.png
│   ├── lfs.png
│   ├── linuxmint.png
│   ├── lubuntu.png
│   ├── mageia.png
│   ├── manjaro.png
│   ├── opensuse.png
│   ├── siduction.png
│   ├── steamos.png
│   ├── ubuntu.png
│   ├── windows.png
│   └── xubuntu.png
├── LICENSE
├── README.md
├── Screenshot.png
├── theme.txt
├── VerBd.pf2
└── VerMono.pf2

1 directory, 37 files
```




## 設定採用

接著來說明，如何設定「GRUB」採用某個佈景主題

主要是編輯「`/etc/default/grub`」這個檔案

``` sh
sudo vi /etc/default/grub
```

加入下面這一行

```
GRUB_THEME='/boot/grub/themes/dracula/theme.txt'
```

或是也可以產生一個檔案「`/etc/default/grub.d/theme.cfg`」，加入上面的設定，執行指令如下

``` sh
cat << EOF | sudo tee /etc/default/grub.d/theme.cfg
GRUB_THEME='/boot/grub/themes/dracula/theme.txt'

EOF
```


接著執行下面指令，重新產生「`/boot/grub/grub.cfg`」這個設定檔。

``` sh
sudo update-grub
```

若沒有「`update-grub`」這個指令，可以改採下面的指令

``` sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```


> 關於「[update-grub](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/command/update-grub.html)」這個指令，裡面也是執行「`grub-mkconfig -o /boot/grub/grub.cfg`」，可以參考「[另一篇](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/command/update-grub.html)」的探索紀錄。


## 輔助工具

| 工具 | 簡介 |
| --- | --- |
| [grubrc-theme-get](https://samwhelp.github.io/note-about-grub/read/project/grubrc-profile/grubrc-theme-get.html) | 用來輔助「安裝」GRUB佈景主題 |
| [grubrc-theme-ctrl](https://samwhelp.github.io/note-about-grub/read/project/grubrc-profile/grubrc-theme-ctrl.html) | 用來輔助「切換」GRUB佈景主題 |


根據上面的原理，我開發了兩個輔助指令工具「grubrc-theme-get」和「grubrc-theme-ctrl」。


以上面安裝「[Dracula](https://github.com/zshzero/dracula-grub2/)」的例子

可以執行下面指令

``` sh
grubrc-theme-get dracula
```

就會安裝「[Dracula](https://github.com/zshzero/dracula-grub2/)」這個佈景主題到「/boot/grub/themes/dracula」。


接著再執行下面指令


``` sh
grubrc-theme-ctrl set dracula
```

就會編輯「/etc/default/grub」這個檔案，

設定「GRUB_THEME="/boot/grub/themes/dracula/theme.txt"」，

並且執行「`sudo update-grub`」這個動作。


這兩個工具還有其他的功能，就請參考上面所列的說明頁面。

例如，可以執行「`grubrc-theme-ctrl fzf`」，就會顯示「所有的佈景主題選單」供您選擇採用。





| 輔助工具 | 簡介 |
| ------ | --- |
| [grub-theme-refactoring-select](https://samwhelp.github.io/grub-theme-refactoring-select/) | 用來輔助「安裝」和「切換」GRUB佈景主題 |
| [grub-theme-remix-select](https://samwhelp.github.io/grub-theme-remix-select/) | 用來輔助「安裝」和「切換」GRUB佈景主題 |
| [grub-theme-select](https://samwhelp.github.io/grub-theme-select/) | 用來輔助「安裝」和「切換」GRUB佈景主題 |




## 預覽工具

可以採用「[grub2-theme-preview](https://samwhelp.github.io/note-about-manjaro/read/adjustment/tool/grub2-theme-preview.html)」，來預覽「GRUB佈景主題」。

執行下面指令來預覽

``` sh
grub2-theme-preview /boot/grub/themes/dracula
```




## See Also

| See Also |
| --- |
| [Grub2 theme tutorial](http://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial) |
| [Grub2 theme reference](http://wiki.rosalab.ru/en/index.php/Grub2_theme_/_reference) |
| [Theme file format](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html) |




## 接下來

> 這篇說明在「`/etc/default/grub`」設定「`GRUB_THEME`」這個參數，接下來探索『[如何同時也可以設定「`GRUB_BACKGROUND`」](https://samwhelp.github.io/note-about-grub/read/howto/use_background_image.html)』這個參數。




## Grub Theme / Glass Series

| Base | Remix |
| ---- | ----- |
| [grub-theme-score](https://github.com/samwhelp/grub-theme-score) | [grub-theme-score-remix](https://github.com/samwhelp/grub-theme-score-remix) |
| [grub-theme-glass](https://github.com/samwhelp/grub-theme-glass) | [grub-theme-glass-remix](https://github.com/samwhelp/grub-theme-glass-remix) |
| [grub-theme-cover](https://github.com/samwhelp/grub-theme-cover) | [grub-theme-cover-remix](https://github.com/samwhelp/grub-theme-cover-remix) |
| [grub-theme-banner](https://github.com/samwhelp/grub-theme-banner) | [grub-theme-banner-remix](https://github.com/samwhelp/grub-theme-banner-remix) |
| [grub-theme-cross](https://github.com/samwhelp/grub-theme-cross) | [grub-theme-cross-remix](https://github.com/samwhelp/grub-theme-cross-remix) |




## Grub Theme / Image Creation

| Link | GitHub |
| ---- | ------ |
| [demo-grub-theme-image-creation](https://samwhelp.github.io/demo-grub-theme-image-creation/) | [GitHub](https://github.com/samwhelp/demo-grub-theme-image-creation) |
