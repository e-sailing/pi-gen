#!/bin/bash -e

on_chroot << EOF
sed -i.bak 's/^\(hdmi_group=\).*/\12/' /boot/config.txt
sed -i.bak 's/^\(hdmi_mode=\).*/\14/' /boot/config.txt
apt-get update
apt-get dist-upgrade -y
EOF
