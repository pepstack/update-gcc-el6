# buildenv.sh
# 2021-02-25
# /etc/profile.d/buildenv.sh
# source /etc/profile.d/buildenv.sh
export CC=/usr/local/gcc/bin/gcc
export CXX=/usr/local/gcc/bin/g++
export PATH=/usr/local/gcc/bin:/usr/local/cmake/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc/lib64:/usr/local/gmp/lib:/usr/local/mpfr/lib:/usr/local/mpc/lib:$LD_LIBRARY_PATH

