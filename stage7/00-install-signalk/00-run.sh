#!/bin/bash -e

on_chroot << EOF
curl -sL https://deb.nodesource.com/setup_8.x | bash -
EOF
