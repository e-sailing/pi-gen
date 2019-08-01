#!/bin/bash -e

#set openplotter.local
on_chroot << EOF
sed -i -e '$ a\' -e "10.10.10.1	openplotter.local openplotter" /etc/hosts
EOF

#start hostapd server
on_chroot << EOF
systemctl enable hostapd
EOF

#start vnc server
on_chroot << EOF
systemctl enable vncserver-x11-serviced.service
EOF

#set hostapd conf
on_chroot << EOF
echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' > /etc/default/hostapd
EOF

#add cron task
on_chroot << EOF
echo "@reboot /bin/bash /home/pi/.openplotter/start-ap-managed-wifi.sh" > /var/spool/cron/crontabs/root
chgrp crontab /var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
EOF

#add script to install non supported wifi device drivers
on_chroot << EOF
wget http://www.fars-robotics.net/install-wifi -O /usr/bin/install-wifi
chmod +x /usr/bin/install-wifi
EOF

#copy files
# display for headless
install -m 644 files/dispsetup.sh		"${ROOTFS_DIR}/usr/share/"

install -m 644 files/dnsmasq.conf		"${ROOTFS_DIR}/etc/"
install -m 644 files/dhcpcd.conf		"${ROOTFS_DIR}/etc/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network/.openplotter"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network/hostapd"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network/systemd"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network/systemd/network"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network/udev"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.openplotter/Network/udev/rules.d"

install -m 644 -o 1000 -g 1000 files/start-ap-managed-wifi.sh		"${ROOTFS_DIR}/home/pi/.openplotter/"
install -m 644 -o 1000 -g 1000 files/start1.sh						"${ROOTFS_DIR}/home/pi/.openplotter/"
install -m 644 -o 1000 -g 1000 files/iptables.sh					"${ROOTFS_DIR}/home/pi/.openplotter/"
install -m 644 -o 1000 -g 1000 files/start-ap-managed-wifi.sh		"${ROOTFS_DIR}/home/pi/.openplotter/Network/.openplotter/"
install -m 644 -o 1000 -g 1000 files/start1.sh						"${ROOTFS_DIR}/home/pi/.openplotter/Network/.openplotter/"
install -m 644 -o 1000 -g 1000 files/iptables.sh					"${ROOTFS_DIR}/home/pi/.openplotter/Network/.openplotter/"
install -m 644 -o 1000 -g 1000 files/hostapd.conf					"${ROOTFS_DIR}/etc/hostapd/"
install -m 644 -o 1000 -g 1000 files/hostapd.conf					"${ROOTFS_DIR}/home/pi/.openplotter/Network/hostapd/"
rm -f "${ROOTFS_DIR}/lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant"
install -m 644 -o 1000 -g 1000 files/10-wpa_supplicant_wlan9		"${ROOTFS_DIR}/lib/dhcpcd/dhcpcd-hooks"
install -m 644 -o 1000 -g 1000 files/72-wireless.rules				"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 -o 1000 -g 1000 files/72-wireless.rules				"${ROOTFS_DIR}/home/pi/.openplotter/Network/udev/rules.d/"
install -m 644 -o 1000 -g 1000 files/11-openplotter-usb0.rules		"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 -o 1000 -g 1000 files/11-openplotter-usb0.rules		"${ROOTFS_DIR}/home/pi/.openplotter/Network/udev/rules.d/"