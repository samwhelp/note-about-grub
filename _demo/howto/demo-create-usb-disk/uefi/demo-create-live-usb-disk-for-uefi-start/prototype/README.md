

# demo-create-live-usb-disk-for-uefi-start




## Usage


### install

run

``` sh
./install.sh
```

or run

``` sh
make install
```




## Code


> grub-mkimage (short option version)

``` sh

mod_main_install_for_uefi_uefi_boot_image_create () {


	sudo mkdir -p mnt/EFI/BOOT mnt/EFI/grub


	sudo cp /usr/lib/grub/x86_64-efi/. mnt/EFI/grub/x86_64-efi -rf




	sudo grub-mkimage \
		-O x86_64-efi \
		-o mnt/EFI/BOOT/bootx64.efi \
		-d mnt/EFI/grub/x86_64-efi \
		-p /EFI/grub \
			fat \
			iso9660 \
			part_gpt \
			part_msdos \
			normal \
			boot \
			linux \
			linux16 \
			configfile \
			loopback \
			chain \
			efifwsetup \
			efi_gop \
			efi_uga \
			ls \
			search \
			search_label \
			search_fs_uuid \
			search_fs_file \
			gfxterm \
			gfxterm_background \
			gfxterm_menu \
			test \
			all_video \
			loadenv \
			exfat \
			ext2 \
			ntfs \
			btrfs \
			hfsplus \
			udf \
			cat




	return 0

}

```

> grub-mkimage (long option version)


``` sh

	sudo grub-mkimage \
		--format="x86_64-efi" \
		--output="mnt/EFI/BOOT/bootx64.efi" \
		--directory="mnt/EFI/grub/x86_64-efi" \
		--prefix="/EFI/grub" \
			fat \
			iso9660 \
			part_gpt \
			part_msdos \
			normal \
			boot \
			linux \
			linux16 \
			configfile \
			loopback \
			chain \
			efifwsetup \
			efi_gop \
			efi_uga \
			ls \
			search \
			search_label \
			search_fs_uuid \
			search_fs_file \
			gfxterm \
			gfxterm_background \
			gfxterm_menu \
			test \
			all_video \
			loadenv \
			exfat \
			ext2 \
			ntfs \
			btrfs \
			hfsplus \
			udf \
			cat




	return 0

}

```
