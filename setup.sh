#!/bin/bash

if [ "$(whoami)" != "root" ]; then
  echo "root privilege required"
  exit 1
fi

if [ -d "/opt/packer" ]; then
  echo "Error, target '/opt/packer' existed, and it is a directory"
  exit 1
fi

if [ -x "/opt/packer" ]; then
  echo "Skip, packer has already existed (Version: "$(/opt/packer --version)")"
  exit 0
fi

PACKER_VERSION="${PACKER_VERSION:-1.1.2}"
echo "Setup packer ${PACKER_VERSION} in process... "
wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -qO /tmp/packer.zip
unzip -q -o -d /opt /tmp/packer.zip
[ $? -eq 0 ] && echo "Done" || echo "Failed"

rm -f /tmp/packer.zip
