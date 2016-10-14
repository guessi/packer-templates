#!/bin/bash

if [ "$(whoami)" != "root" ]; then
  echo "root privilege required"
  exit 1
fi

apt-get install -y unzip

VERSION="0.10.2"
wget https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip -qO /tmp/packer.zip
pushd /opt >/dev/null
unzip -o /tmp/packer.zip
popd >/dev/null
rm -vf /tmp/packer.zip

apt-get install -y libvirt-bin qemu-kvm
apt-get install -y libguestfs-tools
