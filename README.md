### Overview

Packer templates for creating **version control** images


### Prerequisites

* Packer >= 1.1.2
* QEMU >= 2.5.0
* libguestfs-tools >= 1.32.2
* RAM >= 8G
* Disk space for /tmp >= 4G


### Packer Installation

    $ sudo ./setup.sh


### Usage

    $ /usr/local/bin/packer build <path-to-json>


### Support OS distributions

* ~~Ubuntu Server 12.04 LTS (Precise Pangolin)~~
* Ubuntu Server 14.04 LTS (Trusty Tahr)
* Ubuntu Server 16.04 LTS (Xenial Xerus)


### Support output format

* ova
* qcow2


### Reference

* https://www.packer.io/intro
* http://www.ubuntu.com/server
* https://developercenter.vmware.com/web/dp/tool/vsphere_cli/6.0
