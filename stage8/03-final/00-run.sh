#!/bin/bash -e

sed -i "s/#hdmi_group=1/hdmi_group=2/g" "${ROOTFS_DIR}/boot/config.txt"
sed -i "s/#hdmi_mode=1/hdmi_mode=82/g" "${ROOTFS_DIR}/boot/config.txt"
sed -i "s/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/g" "${ROOTFS_DIR}/boot/config.txt"

on_chroot << EOF
apt-get update
apt-get dist-upgrade -y
EOF
