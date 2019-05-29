#!/bin/bash -e

#install gqrx
on_chroot << EOF
cd /opt
rm -f gqrx-sdr-2.11.5-linux-rpi3.tar.xz
rm -rf gqrx
rm -rf gqrx-sdr-2.11.5-linux-rpi3
wget https://github.com/csete/gqrx/releases/download/v2.11.5/gqrx-sdr-2.11.5-linux-rpi3.tar.xz
tar xf gqrx-sdr-2.11.5-linux-rpi3.tar.xz
rm -f gqrx-sdr-2.11.5-linux-rpi3.tar.xz
mv gqrx-sdr-2.11.5-linux-rpi3 gqrx
cd gqrx
cp udev/*.rules /etc/udev/rules.d/
EOF

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/gqrx"
install -m 644 -o 1000 -g 1000 files/default.conf		"${ROOTFS_DIR}/home/pi/.config/gqrx/"
install -m 644 -o 1000 -g 1000 files/bookmarks.csv		"${ROOTFS_DIR}/home/pi/.config/gqrx/"
rm -f "${ROOTFS_DIR}/usr/share/applications/gnuradio-grc.desktop"
