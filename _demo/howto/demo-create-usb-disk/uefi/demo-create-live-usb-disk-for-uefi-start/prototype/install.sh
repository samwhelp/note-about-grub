#!/usr/bin/env bash


################################################################################
### Head: Note
##

##
## ## Link
##
## * https://github.com/samwhelp/skel-project-plan/blob/master/develop/sh/project-helper/basic/helper/bin/prepare.sh
##

##
### Tail: Note
################################################################################


################################################################################
### Head: Init
##

#set -e

THE_BASE_DIR_PATH="$(cd -- "$(dirname -- "${0}")" ; pwd)"
#THE_INIT_DIR_PATH="${THE_BASE_DIR_PATH}/helper/ext"
#. "${THE_INIT_DIR_PATH}/init.sh"

##
### Tail: Init
################################################################################




################################################################################
### Head: Util / Debug
##

util_debug_echo () {

	if is_debug; then
		echo "${@}" 1>&2
	fi

}

util_error_echo () {

	echo "${@}" 1>&2

}

##
### Head: Util / Debug
################################################################################


################################################################################
### Head: Base
##

##
## THE_BASE_DIR_PATH="$(cd -- "$(dirname -- "$0")" ; pwd)"
##

find_dir_path () {

	if ! [ -d "$(dirname -- "${1}")" ]; then
		dirname -- "${1}"
		return 1
	fi
	echo "$(cd -- "$(dirname -- "${1}")" ; pwd)"

}

##
## THIS_BASE_DIR_PATH="$(find_dir_path "${0}")"
##


##
## $ export DEBUG_HELPER=true
##

is_debug () {

	if [ "${DEBUG_HELPER}" = "true" ]; then
		return 0
	fi

	return 1

}

is_not_debug () {

	! is_debug

}

##
### Tail: Base
################################################################################




################################################################################
### Head: Model / live_usb_disk_for_uefi_partition_create
##

live_usb_disk_for_uefi_partition_create () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## live_usb_disk_for_uefi_partition_create"
	util_error_echo "##"
	util_error_echo


	mod_partition_create_for_uefi "/dev/sdc"

	return 0
}

mod_partition_create_for_uefi () {

	local disk_target="${1}"
	##local disk_target="/dev/sdc"

	local part_uefi="${disk_target}1"

	sudo parted --script -- "${disk_target}" \
		mktable gpt \
		mkpart primary "0%" '100%' \
		set 1 esp on \
		print

	sudo mkfs.fat -F 32 -n LIVEUEFI "${part_uefi}"


	sudo partprobe /dev/sdc

}

##
### Tail: Model / live_usb_disk_for_uefi_partition_create
################################################################################




################################################################################
### Head: Model / live_usb_disk_for_uefi_main_install
##

live_usb_disk_for_uefi_main_install () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## live_usb_disk_for_uefi_main_install"
	util_error_echo "##"
	util_error_echo


	mod_main_install_for_uefi

	return 0
}

mod_main_install_for_uefi () {

	mod_main_install_for_uefi_prepare

	mod_main_install_for_uefi_mount

	mod_main_install_for_uefi_uefi_boot_image_create

	return 0

}

mod_main_install_for_uefi_prepare () {

	##
	## /usr/lib/grub/x86_64-efi
	##

	sudo apt-get install grub-efi-amd64-bin


	##
	## /usr/lib/grub/i386-efi
	##

	#sudo apt-get install grub-efi-ia32-bin


	#sudo apt-get install grub-efi-amd64-bin grub-efi-ia32-bin

	return 0
}

mod_main_install_for_uefi_mount () {


	mkdir -p ./mnt

	sudo umount ./mnt

	sudo umount /dev/sdc1

	sudo mount /dev/sdc1 ./mnt


	return 0

}

mod_main_install_for_uefi_uefi_boot_image_create () {


	cd ./mnt

	sudo mkdir -p EFI/BOOT EFI/grub

	sudo cp /usr/lib/grub/x86_64-efi/. EFI/grub/x86_64-efi -rf



	sudo grub-mkimage \
		-O x86_64-efi \
		-o EFI/BOOT/bootx64.efi \
		-d /usr/lib/grub/x86_64-efi \
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


	cd "${OLDPWD}"

	return 0

}

##
### Tail: Model / live_usb_disk_for_uefi_main_install
################################################################################




################################################################################
### Head: Model / Start
##

main_usb_disk_create () {

	#util_error_echo 'main_usb_disk_create'

	live_usb_disk_for_uefi_partition_create

	live_usb_disk_for_uefi_main_install




	return 0

}

##
### Tail: Model / Start
################################################################################


################################################################################
### Head: Main
##

__main__ () {

	main_usb_disk_create "${@}"

}

__main__ "${@}"

##
### Tail: Main
################################################################################
