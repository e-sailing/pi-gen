#!/bin/bash -e

#install sk
on_chroot << EOF
npm install --verbose -g --unsafe-perm signalk-server
EOF

#config sk
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.signalk"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data"
install -m 644 -o 1000 -g 1000 files/.npmrc		"${ROOTFS_DIR}/home/pi/.signalk/"
install -m 644 -o 1000 -g 1000 files/package.json		"${ROOTFS_DIR}/home/pi/.signalk/"
install -m 644 -o 1000 -g 1000 files/settings.json		"${ROOTFS_DIR}/home/pi/.signalk/"
install -m 775 -o 1000 -g 1000 files/signalk-server		"${ROOTFS_DIR}/home/pi/.signalk/"
install -m 644 -o 1000 -g 1000 files/defaults.json		"${ROOTFS_DIR}/home/pi/.signalk/"

#autorun sk
install -m 644 files/signalk.service		"${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/signalk.socket		"${ROOTFS_DIR}/etc/systemd/system/"
on_chroot << EOF
systemctl daemon-reload
systemctl enable signalk.service
systemctl enable signalk.socket
systemctl stop signalk.service
systemctl restart signalk.socket
systemctl restart signalk.service
EOF
