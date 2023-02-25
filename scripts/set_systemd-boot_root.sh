#!/bin/sh
#
# Sets the root partition in systemd-boot entries to the input partition's
# Partion UUID.
#

#---- Parameters ---------------------------------------------------------------
root_part=$1

#---- Functions ----------------------------------------------------------------
usage()
{
	cat << __EOF
Usage:

$0 ROOT_PART

__EOF

}

#---- Main ---------------------------------------------------------------------
if [ -z "$root_part" ]; then
	echo "Error: No root partition specified."
	usage
	exit
fi

part_uuid=$(lsblk -dno PARTUUID $root_part)
entries=$(ls /boot/loader/entries/*.conf)
echo "Will set root partition to: PARTUUID=$part_uuid"
printf "\n"
echo "Will modify the following files:"
echo "$entries"
sed -i.bak -e "s/root\S*/root=PARTUUID=$part_uuid/g" $entries
printf "\n"
