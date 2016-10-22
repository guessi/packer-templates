#!/bin/bash

if [ "$(whoami)" != "root" ]; then
  echo "root privilege required"
  exit 1
fi

VERSION="0.10.2"
wget https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip -qO /tmp/packer.zip
pushd /opt >/dev/null
unzip -o /tmp/packer.zip
popd >/dev/null
rm -vf /tmp/packer.zip
