#!/bin/bash -e

install -m 644 files/openplotter.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
install -m 644 files/preferences "${ROOTFS_DIR}/etc/apt/preferences.d/"

on_chroot apt-key add - < files/opencpn.gpg.key
on_chroot apt-key add - < files/openplotter.gpg.key
on_chroot apt-key add - < files/grafana.gpg.key
on_chroot apt-key add - < files/influxdb.gpg.key
on_chroot apt-key add - < files/nodesource.gpg.key
on_chroot << EOF
apt-get update
EOF
