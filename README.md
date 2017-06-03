### Overview

Packer templates for creating **version control** images


### Prerequisites

* Packer >= 0.12.3, recommend: >=1.0.0
* QEMU >=2.0.0, recommend: >=2.5.0
* libguestfs-tools >=1.24.5, recommend: >=1.32.2
* RAM: 8G, recommend: 16G
* partition space for /tmp: 4G, recommend: 8G


### Packer Installation

    $ sudo ./setup.sh

or specify version explicitly

    $ sudo PACKER_VERSION=1.0.0 ./setup.sh


### Usage

    $ /opt/packer build <path-to-json>


### Support OS distributions

* ~~Ubuntu Server 12.04 LTS~~
* Ubuntu Server 14.04 LTS
* Ubuntu Server 16.04 LTS


### Support output format

* ova
* qcow2


### Reference

* https://www.packer.io/intro
* http://www.ubuntu.com/server
* https://developercenter.vmware.com/web/dp/tool/vsphere_cli/6.0
