#!/bin/bash

if [ "$(lsb_release -sc)" = "xenial" ]; then
  KERNEL_VERSION="xenial"
elif [ "$(lsb_release -sc)" = "trusty" ]; then
  KERNEL_VERSION="xenial"
elif [ "$(lsb_release -sc)" = "precise" ]; then
  KERNEL_VERSION="trusty"
fi

# general
sed -i '/force_color_prompt/s/^#//' /home/*/.bashrc
sed -i 's/us.archive./tw.archive./g' /etc/apt/sources.list

# kernel
apt-get -q update

if [ -n "${KERNEL_VERSION}" ]; then
  dpkg -l | awk '/linux-(image|headers|generic|virtual|signed)/{print$2}' | xargs apt-get purge -y

  if [ "$(lsb_release -sc)" != "precise" ]; then
    EXTRA="linux-image-extra-virtual-lts-${KERNEL_VERSION}"
  fi

  apt-get install -qy \
    linux-image-generic-lts-${KERNEL_VERSION} \
    linux-headers-generic-lts-${KERNEL_VERSION} ${EXTRA}
fi

# upgrade
apt-get dist-upgrade -qy

# grub
echo "GRUB_RECORDFAIL_TIMEOUT=0" | tee -a /etc/default/grub
sed -i -e '/GRUB_CMDLINE_LINUX_DEFAULT/s/^.*$/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttyS0,115200n8\"/g' \
       -e '/GRUB_TERMINAL/s/^.*$/GRUB_TERMINAL=\"console\"/g' \
       -e '/GRUB_GFXMODE/s/^.*$/GRUB_GFXMODE=\"800x600\"/g' \
       -e '/GRUB_TIMEOUT/s/^.*$/GRUB_TIMEOUT=0/g' \
       /etc/default/grub

update-grub

# sshd
if ! grep "UseDNS" /etc/ssh/sshd_config; then
  echo "UseDNS no" | tee -a /etc/ssh/sshd_config
fi
sed -i '/^PermitRootLogin/s/^.*$/PermitRootLogin no/g' /etc/ssh/sshd_config

# ttyS0.conf
cat > /etc/init/ttyS0.conf << EOF
# ttyS0 - getty
#
# This service maintains a getty on ttyS0 from the point the system is
# started until it is shut down again.

start on stopped rc or RUNLEVEL=[12345]
stop on runlevel [!12345]

respawn
exec /sbin/getty -L 115200 ttyS0 vt102
EOF

# lock out root account
passwd -l root
usermod -s /usr/sbin/nologin root
