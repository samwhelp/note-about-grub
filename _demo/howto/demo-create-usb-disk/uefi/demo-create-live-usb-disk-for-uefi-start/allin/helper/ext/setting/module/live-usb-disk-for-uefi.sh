

################################################################################
### Head: Setting / Module / Live-Usb-Disk-Dor-Uefi / Variable
##

live_usb_disk_for_uefi_var_init () {

	THE_GNOME_SHELL_CONFIG_MAIN_GSCHEMA_OVERRIDE_FILE_NAME="50_gnome-shell-config-main.gschema.override"

	THE_GNOME_SHELL_CONFIG_MAIN_SOURCE_GSCHEMA_OVERRIDE_FILE_PATH="${THE_SOURCE_GSCHEMA_DIR_PATH}/${THE_GNOME_SHELL_CONFIG_MAIN_GSCHEMA_OVERRIDE_FILE_NAME}"
	THE_GNOME_SHELL_CONFIG_MAIN_TARGET_GSCHEMA_OVERRIDE_FILE_PATH="${THE_TARGET_GSCHEMA_DIR_PATH}/${THE_GNOME_SHELL_CONFIG_MAIN_GSCHEMA_OVERRIDE_FILE_NAME}"

	return 0

}

live_usb_disk_for_uefi_var_dump () {


	is_not_debug && return 0




	util_debug_echo
	util_debug_echo "################################################################################"
	util_debug_echo "### Head: live_usb_disk_for_uefi_var_dump"
	util_debug_echo "##"
	util_debug_echo


	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Live-Usb-Disk-Dor-Uefi / Gschema"
	util_debug_echo "##"
	util_debug_echo

	util_debug_echo "THE_GNOME_SHELL_CONFIG_MAIN_GSCHEMA_OVERRIDE_FILE_NAME=${THE_GNOME_SHELL_CONFIG_MAIN_GSCHEMA_OVERRIDE_FILE_NAME}"
	util_debug_echo

	util_debug_echo "THE_GNOME_SHELL_CONFIG_MAIN_SOURCE_GSCHEMA_OVERRIDE_FILE_PATH=${THE_GNOME_SHELL_CONFIG_MAIN_SOURCE_GSCHEMA_OVERRIDE_FILE_PATH}"
	util_debug_echo "THE_GNOME_SHELL_CONFIG_MAIN_TARGET_GSCHEMA_OVERRIDE_FILE_PATH=${THE_GNOME_SHELL_CONFIG_MAIN_TARGET_GSCHEMA_OVERRIDE_FILE_PATH}"
	util_debug_echo

	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "### Tail: live_usb_disk_for_uefi_var_dump"
	util_debug_echo "################################################################################"
	util_debug_echo


	util_debug_echo
	util_debug_echo
	util_debug_echo


	return 0

}

live_usb_disk_for_uefi_var_init
live_usb_disk_for_uefi_var_dump

##
### Tail: Setting / Module / Live-Usb-Disk-Dor-Uefi / Variable
################################################################################


################################################################################
### Head: Setting / Module / Live-Usb-Disk-Dor-Uefi / Portal
##

live_usb_disk_for_uefi_partition_create () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## live_usb_disk_for_uefi_partition_create"
	util_error_echo "##"
	util_error_echo




	live_usb_disk_for_uefi_modeling_partition_create


	return 0

}


##
### Tail: Setting / Module / Live-Usb-Disk-Dor-Uefi / Portal
################################################################################


################################################################################
### Head: Setting / Module / Live-Usb-Disk-Dor-Uefi / Model
##

live_usb_disk_for_uefi_modeling_partition_create () {


	util_error_echo
	util_error_echo "live_usb_disk_for_uefi_modeling_partition_create"



	return 0
}

##
### Tail: Setting / Module / Live-Usb-Disk-Dor-Uefi / Model
################################################################################
