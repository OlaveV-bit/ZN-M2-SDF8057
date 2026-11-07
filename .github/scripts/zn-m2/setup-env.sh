#!/bin/bash
set -euo pipefail
sudo -E apt-get -qq update
sudo -E apt-get -qq install -y build-essential clang flex bison gawk gettext git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev file wget
sudo -E apt-get -qq autoremove --purge
sudo -E apt-get -qq clean
sudo timedatectl set-timezone "$TZ"
sudo mkdir -p /workdir
sudo chown $USER:$GROUPS /workdir
