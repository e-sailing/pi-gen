#!/bin/bash -e

on_chroot << EOF
sudo -u pi pulseaudio --start
EOF

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/gqrx"
install -m 644 -o 1000 -g 1000 files/default.conf		"${ROOTFS_DIR}/home/pi/.config/gqrx/"
install -m 644 -o 1000 -g 1000 files/bookmarks.csv		"${ROOTFS_DIR}/home/pi/.config/gqrx/"
install -m 644 files/udev/52-airspy.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/52-airspyhf.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/53-hackrf.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/66-mirics.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/fcd.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/fcdpp.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/rtl-sdr.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/udev/sdriq.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
rm -f "${ROOTFS_DIR}/usr/share/applications/gqrx.desktop"