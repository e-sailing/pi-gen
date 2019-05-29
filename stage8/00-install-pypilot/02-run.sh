#!/bin/bash -e

#config pypilot
install -m 644 files/gpsd		"${ROOTFS_DIR}/etc/default/"
install -m 644 files/gpsd.socket		"${ROOTFS_DIR}/lib/systemd/system/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.pypilot"
install -m 644 -o 1000 -g 1000 files/signalk.conf		"${ROOTFS_DIR}/home/pi/.pypilot/"
