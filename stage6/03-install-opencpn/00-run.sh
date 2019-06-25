#!/bin/bash -e

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.opencpn"
install -m 644 -o 1000 -g 1000 files/opencpn.conf		"${ROOTFS_DIR}/home/pi/.opencpn/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/Desktop"
install -m 644 -o 1000 -g 1000 files/opencpn.desktop		"${ROOTFS_DIR}/home/pi/Desktop/"
