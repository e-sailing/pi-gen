#!/bin/bash -e

on_chroot << EOF
apt-get update
apt-get dist-upgrade -y
EOF
