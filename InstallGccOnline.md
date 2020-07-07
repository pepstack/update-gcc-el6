# Online Installation of GCC On CentOS7

[为CentOS 6、7升级gcc至4.8、4.9、5.2、6.3、7.3等高版本](https://www.vpser.net/manage/centos-6-upgrade-gcc.html)

run as root


## 升级到 gcc-8

    yum -y install centos-release-scl

    yum -y install devtoolset-8-gcc devtoolset-8-gcc-c++ devtoolset-8-binutils

    scl enable devtoolset-8 bash


需要注意的是scl命令启用只是临时的，退出shell或重启就会恢复原系统gcc版本。

如果要长期使用gcc 8.3的话：

    echo "source /opt/rh/devtoolset-8/enable" >>/etc/profile

## 升级到 gcc-9

    yum -y install centos-release-scl

    yum -y install devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils

    scl enable devtoolset-9 bash

需要注意的是scl命令启用只是临时的，退出shell或重启就会恢复原系统gcc版本。

如果要长期使用gcc 9.3的话：

    echo "source /opt/rh/devtoolset-9/enable" >>/etc/profile
