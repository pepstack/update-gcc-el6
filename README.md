# UPDATE GCC On RHEL6 (x64)

This document was powered by [markdown-editor](https://jbt.github.io/markdown-editor/)

reference: [安装GCC-8.3.0及其依赖](https://www.cnblogs.com/aquester/p/10799125.html)

author: 350137278@qq.com


## 1. Downloads all packages

- gcc source

    [gcc-6.4.0.tar.xz](https://mirrors.tuna.tsinghua.edu.cn/gnu/gcc/)
    
- cmake bin

    [cmake-3.14.7](https://cmake.org/files/v3.14/cmake-3.14.7-Linux-x86_64.sh)

- dependencies for gcc

    [m4-1.4.18.tar.gz](https://mirrors.tuna.tsinghua.edu.cn/gnu/m4/)

    [gmp-6.1.2.tar.bz2](https://mirrors.tuna.tsinghua.edu.cn/gnu/gmp/)

    [mpfr-4.0.2](https://mirrors.tuna.tsinghua.edu.cn/gnu/mpfr/)

    [mpc-1.1.0](https://mirrors.tuna.tsinghua.edu.cn/gnu/mpc/)

 - 3rd-party libraries
 
    [leveldb](https://github.com/google/leveldb)
    
    [RedisGraph](https://github.com/RedisGraph/RedisGraph)

    deps: [peg/leg - recursive-descent parser generators for C](https://www.piumarta.com/software/peg/peg-0.1.18.tar.gz)

## 2. Build and install dependencies

- gmp

        # tar xvf gmp-6.1.2.tar.bz2
        # cd gmp-6.1.2
        # ./configure --prefix=/usr/local/gmp-6.1.2
        # make
        # make install
        # ln -s /usr/local/gmp-6.1.2 /usr/local/gmp

- mpfr

        # tar xzf  mpfr-4.0.2.tar.gz
        # cd mpfr-4.0.2
        # ./configure --prefix=/usr/local/mpfr-4.0.2 --with-gmp=/usr/local/gmp
        # make
        # make install
        # ln -s /usr/local/mpfr-4.0.2 /usr/local/mpfr

- mpc

        # tar xzf  mpc-1.1.0.tar.gz
        # cd mpc-1.1.0
        # ./configure --prefix=/usr/local/mpc-1.1.0 --with-gmp=/usr/local/gmp --with-mpfr=/usr/local/mpfr
        # make
        # make install
        # ln -s /usr/local/mpc-1.1.0 /usr/local/mpc

## 3. Build gcc-6.4.0

        # export LD_LIBRARY_PATH=/usr/local/gmp/lib:/usr/local/mpfr/lib:/usr/local/mpc/lib:$LD_LIBRARY_PATH

        # tar xvf gcc-6.4.0.tar.xz
        # cd gcc-6.4.0
        # ./configure --prefix=/usr/local/gcc-6.4.0 --with-mpfr=/usr/local/mpfr --with-gmp=/usr/local/gmp --with-mpc=/usr/local/mpc --disable-multilib
        # make
        # make install
        # ln -s /usr/local/gcc-6.4.0 /usr/local/gcc


        # export PATH=/usr/local/gcc/bin:$PATH
        # export LD_LIBRARY_PATH=/usr/local/gcc/lib64:$LD_LIBRARY_PATH
        # export MANPATH=/usr/local/gcc/share/man:$MANPATH
        # gcc --version

## 4. Install cmake-3.14.7-Linux-x86_64.sh

        # chmod +x cmake-3.14.7-Linux-x86_64.sh
        # ./cmake-3.14.7-Linux-x86_64.sh
        # cmake --version


## 5. Build leveldb on rhel6

see also: [leveldb在Windows和Linux上编译](https://blog.csdn.net/ubuntu64fan/article/details/102932752)

- build linux static release lib ONLY for C++:  xbuild/libleveldb.a

(C++ 语言可以链接到静态库libleveldb.a上的)

        # source buildenv.conf

        # tar -zxf leveldb.tar.gz
        # cd leveldb/
        # mkdir xbuild
        # cd xbuild
        # cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build .

optionally copy out headers and static lib:

        # cd leveldb/
        # cp -r include/leveldb /path/to/libs/include/
        # cp xbuild/libleveldb.a /path/to/libs/lib/

- build linux shared release dll for both C and C++:  libleveldb.so

(C 语言一定是要链接到动态库libleveldb.so上的： -lleveldb)

        # cd leveldb/
        # cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=on .
        # make all

optionally copy out headers and shared dll:

        # cd leveldb/
        # cp -r include/leveldb /path/to/libs/include/
        # cp libleveldb.so.1.22.0 /path/to/libs/lib/
        # cd /path/to/libs/lib/
        # ln -s libleveldb.so.1.22.0 libleveldb.so.1
        # ln -s libleveldb.so.1 libleveldb.so


## 6. Build RedisGraph on rhel6

see also: [RedisGraph](https://oss.redislabs.com/redisgraph/) - a graph database module for Redis

build redis module (linux dynamic release so):src/redisgraph.so

- install peg/leg first

        # tar -zxf peg-0.1.18.tar.gz
        # cd peg-0.1.18
        # make
        # make install

- build RedisGraph.so then

        # export CC=/usr/local/gcc/bin/gcc
        # export CXX=/usr/local/gcc/bin/g++
        # export PATH=/usr/local/gcc/bin:$PATH
        # export LD_LIBRARY_PATH=/usr/local/gcc/lib64:/usr/local/gmp/lib:/usr/local/mpfr/lib:/usr/local/mpc/lib:$LD_LIBRARY_PATH

        # tar -zxf RedisGraph-2.0.0.tar.gz
        # cd RedisGraph
        # make
