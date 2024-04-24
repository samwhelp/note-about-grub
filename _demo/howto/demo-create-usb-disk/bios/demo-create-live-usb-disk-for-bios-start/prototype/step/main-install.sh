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

set -e

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
### Head: Model / mod_main_install_for_bios_umount
##

mod_main_install_for_bios_umount_mnt () {

	if sudo umount ./mnt; then
		return 0
	fi


	return 0

}

mod_main_install_for_bios_umount_dev () {

	if sudo umount /dev/sdc*; then
		return 0
	fi


	return 0

}

##
### Tail: Model / mod_main_install_for_bios_umount
################################################################################




################################################################################
### Head: Model / live_usb_disk_for_bios_main_install
##

live_usb_disk_for_bios_main_install () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## live_usb_disk_for_bios_main_install"
	util_error_echo "##"
	util_error_echo


	mod_main_install_for_bios

	return 0

}

mod_main_install_for_bios () {

	mod_main_install_for_bios_prepare

	mod_main_install_for_bios_mount

	mod_main_install_for_bios_grub_install

	return 0

}

mod_main_install_for_bios_prepare () {

	##
	## /usr/lib/grub/i386-pc/
	##

	sudo apt-get install grub-pc-bin


	return 0

}

mod_main_install_for_bios_mount () {


	mkdir -p ./mnt

	mod_main_install_for_bios_umount_mnt

	mod_main_install_for_bios_umount_mnt

	sudo mount /dev/sdc2 ./mnt


	return 0

}

mod_main_install_for_bios_grub_install () {


	sudo grub-install \
		--boot-directory="mnt/boot" \
		--target="i386-pc" \
		--fonts="unicode" \
		/dev/sdc


	return 0

}

##
### Tail: Model / live_usb_disk_for_bios_main_install
################################################################################




################################################################################
### Head: Model / Start
##

main_usb_disk_create () {

	#util_error_echo 'main_usb_disk_create'

	live_usb_disk_for_bios_main_install




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
