#!/bin/bash -e

on_chroot << EOF
rm -f xygrib-maps_1.2.6-1_all.deb
wget "https://www.free-x.de/raspbian/buster/xygrib-maps_1.2.6-1_all.deb"
dpkg -i xygrib-maps_1.2.6-1_all.deb
rm -f xygrib-maps_1.2.6-1_all.deb
rm -f xygrib_1.2.6-1_armhf.deb
wget "https://www.free-x.de/raspbian/buster/xygrib_1.2.6-1_armhf.deb"
dpkg -i xygrib_1.2.6-1_armhf.deb
rm -f xygrib_1.2.6-1_armhf.deb
EOF

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/Desktop"
install -m 644 -o 1000 -g 1000 files/xygrib.desktop		"${ROOTFS_DIR}/home/pi/Desktop/"
