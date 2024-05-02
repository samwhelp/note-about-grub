---
title: /etc/default/grub
nav_order: 1020
has_children: false
parent: 入門
---


# /etc/default/grub

## Path

* [/etc/default/grub](https://samwhelp.github.io/note-about-grub/read/explore/ubuntu/file/etc_default_grub.html)


## 關於「/etc/default/grub」

延續「[/boot/grub/grub.cfg](https://samwhelp.github.io/note-about-grub/read/start/grub_cfg.html)」這篇提到的，

在實務上，會先修改「/etc/default/grub」這個檔案，

然後再執行下面指令，產生新的「`/boot/grub/grub.cfg`」。

執行
``` sh
sudo update-grub
```

或是執行

``` sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## 使用案例

最常見的使用案例，是設定採用「Grub的佈景主題」，

就會修改「/etc/default/grub」這個檔案。

加入類似下面這一行，

```
GRUB_THEME="/boot/grub/themes/dracula/theme.txt"
```

接著執行下面指令，產生新的「/boot/grub/grub.cfg」。

``` sh
sudo update-grub
```

詳細步驟，請參考另一篇「[設定採用佈景主題](https://samwhelp.github.io/note-about-grub/read/howto/use_theme.html)」的說明。


## 關於「/etc/default/grub.d/」

> 關於「[/etc/default/grub.d/](https://samwhelp.github.io/note-about-grub/read/start/etc_default_grub_d.html)」這個資料夾。




## 接下來

> 接下來，來探索「[/etc/grub.d/](https://samwhelp.github.io/note-about-grub/read/start/etc_grub_d.html)」這個資料夾。
