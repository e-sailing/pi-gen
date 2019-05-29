#!/bin/bash -e

#install sk plugins
on_chroot << EOF
cd /home/pi/.signalk
sudo -u pi npm i --verbose signalk-to-nmea2000
sudo -u pi npm i --verbose @signalk/signalk-node-red
sudo -u pi npm i --verbose @mxtommy/kip
sudo -u pi npm i --verbose @signalk/simulatorplugin
sudo -u pi npm i --verbose signalk-derived-data
sudo -u pi npm i --verbose signalk-to-influxdb
EOF

#config sk plugins
install -m 644 -o 1000 -g 1000 files/set-system-time.json		"${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data/"
install -m 644 -o 1000 -g 1000 files/signalk-node-red.json	"${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data/"
sed -i "s/credentialSecret: 'jkhdfshjkfdskjhfsjfsdkjhsfdjkfsd'/credentialSecret: false/g" "${ROOTFS_DIR}/home/pi/.signalk/node_modules/@signalk/signalk-node-red/index.js"

#install node-red nodes
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.signalk/red"
install -m 644 -o 1000 -g 1000 files/red/package.json	"${ROOTFS_DIR}/home/pi/.signalk/red/"

on_chroot << EOF
cd /home/pi/.signalk/red
sudo -u pi npm i --verbose node-red-dashboard
sudo -u pi npm i --verbose node-red-contrib-chatbot
sudo -u pi npm i --verbose node-red-contrib-msg-resend
sudo -u pi npm i --verbose node-red-contrib-usbcamera
EOF

#preset signalk influxdb
install -m 644 -o 1000 -g 1000 files/plugin-config-data/signalk-to-influxdb.json	"${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data/"

#set bookmarks in chromium
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/chromium"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.config/chromium/Default"
install -m 755 -o 1000 -g 1000 files/Bookmarks	"${ROOTFS_DIR}/home/pi/.config/chromium/Default/"
install -m 755 -o 1000 -g 1000 files/Preferences	"${ROOTFS_DIR}/home/pi/.config/chromium/Default/"

#set grafana to 3001 port
sed -i "s/;http_port = 3000/http_port = 3001/g" "${ROOTFS_DIR}/etc/grafana/grafana.ini"
