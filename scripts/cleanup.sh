#!/bin/sh

# apt
apt-get autoremove -y
apt-get autoclean
apt-get clean

find /var/lib/apt/lists -type f -delete
find /var/cache/apt/archives -type f -delete

# log files
for i in $(find /var/log -maxdepth 1 -type f -print); do echo -n > ${i}; done
for i in err gz log $(seq 0 9); do
  find /var/log/ -name "*.${i}" -delete
done

# home directory
for i in dead.letter .aptitude .bash_history .cache .lesshst .vim .viminfo .ssh .swp; do
  rm -rf /home/*/${i}
  rm -rf /root/${i}
done

# network
echo -n > /etc/udev/rules.d/70-persistent-net.rules
rm -f /var/lib/dhcp/*

# wipeout free space
dd if=/dev/zero of=/tmp/dummy bs=1M
rm -f /tmp/dummy

# misc
rm -rf /var/tmp/* /tmp/*
