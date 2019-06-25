#!/bin/bash -e

#install puthon packages
on_chroot << EOF
pip install pynmea2 websocket-client
EOF

#config MQTT server 
install -m 644 files/mosquitto.conf		"${ROOTFS_DIR}/etc/mosquitto/conf.d/"

#install openplotter
on_chroot << EOF
cd /home/pi/.config
rm -rf openplotter
rm -rf openplotter-2.x.x
rm -f v2.x.x.zip
wget "https://github.com/sailoog/openplotter/archive/v2.x.x.zip"
unzip v2.x.x.zip
mv openplotter-2.x.x openplotter
rm -f v2.x.x.zip
EOF
chown -R 1000:1000 "${ROOTFS_DIR}/home/pi/.config/openplotter"
chmod 775 "${ROOTFS_DIR}/home/pi/.config/openplotter/openplotter"
chmod 775 "${ROOTFS_DIR}/home/pi/.config/openplotter/startup"
echo "export PATH=$PATH:/home/pi/.config/openplotter" >> "${ROOTFS_DIR}/home/pi/.profile"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/autostart"
install -m 644 -o 1000 -g 1000 files/start_openplotter.desktop		"${ROOTFS_DIR}/home/pi/.config/autostart/"
install -m 644 files/OpenPlotter.directory		"${ROOTFS_DIR}/usr/share/raspi-ui-overrides/desktop-directories/"
install -m 644 -o 1000 -g 1000 files/openplotter.desktop		"${ROOTFS_DIR}/home/pi/.local/share/applications/"
install -m 644 -o 1000 -g 1000 files/openplotter_help.desktop		"${ROOTFS_DIR}/home/pi/.local/share/applications/"
install -m 644 -o 1000 -g 1000 files/sdr.desktop "${ROOTFS_DIR}/home/pi/.local/share/applications/"
install -m 644 -o 1000 -g 1000 files/kplex.desktop "${ROOTFS_DIR}/home/pi/.local/share/applications/"
install -m 644 -o 1000 -g 1000 files/moitessier_hat.desktop "${ROOTFS_DIR}/home/pi/.local/share/applications/"
install -m 644 -o 1000 -g 1000 files/signalk.desktop		"${ROOTFS_DIR}/home/pi/.local/share/applications/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/pcmanfm"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE-pi"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/libfm"
install -m 644 -o 1000 -g 1000 files/desktop-items-0.conf		"${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE-pi/"
install -m 644 -o 1000 -g 1000 files/pcmanfm.conf		"${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE-pi/"
install -m 644 -o 1000 -g 1000 files/libfm.conf		"${ROOTFS_DIR}/home/pi/.config/libfm/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/Charts"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/Gribs"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/Logs"
install -m 644 -o 1000 -g 1000 files/.gtk-bookmarks		"${ROOTFS_DIR}/home/pi/"
install -m 644 files/xygrib.desktop		"${ROOTFS_DIR}/usr/share/applications/"
install -m 644 files/opencpn.desktop		"${ROOTFS_DIR}/usr/share/applications/"
install -m 644 files/lxde-pi-applications.menu		"${ROOTFS_DIR}/etc/xdg/menus/"

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/lxpanel"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/lxpanel/LXDE-pi"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/lxpanel/LXDE-pi/panels"
install -m 644 -o 1000 -g 1000 files/panel		"${ROOTFS_DIR}/home/pi/.config/lxpanel/LXDE-pi/panels/"

rm -f "${ROOTFS_DIR}/usr/share/raspi-ui-overrides/applications/raspi_getstart.desktop"
rm -f "${ROOTFS_DIR}/usr/share/raspi-ui-overrides/applications/help.desktop"
rm -f "${ROOTFS_DIR}/usr/share/raspi-ui-overrides/applications/raspi_resources.desktop"
rm -f "${ROOTFS_DIR}/usr/share/raspi-ui-overrides/applications/magpi.desktop"

#install moitessier HAT driver
on_chroot << EOF
cd /home/pi
rm -f moitessier_4.19.42_armhf.deb
wget "https://get.rooco.tech/moitessier/release/4.19.42/latest/moitessier_4.19.42_armhf.deb"
dpkg -i moitessier_4.19.42_armhf.deb
rm -f moitessier_4.19.42_armhf.deb
EOF
