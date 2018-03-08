#!/bin/sh
#
# rpm2cpio.sh: Dump an rpms in cpio format to std out.
#
# Apparently written by Jeff Johnson
#
# Found at https://www.redhat.com/archvies/rpm-list/2003-June/msg00367.html
#
#  Executing
#    rpm2cpio foo.rpm
#  creates
#    foo.cpio
#
#
#  Look at content of created cpio file:
#    cpio -t < ./foo.cpio
#
#  Extract content of cpio file. -d: create directories
#  Maybe, this should be made in a specific directory so
#  that the current directory is not cluttered.
#    cpio -i -d --no-absolute-filenames < ./foo.cpio
# 
#
#  TODO
#    https://stackoverflow.com/a/25986787

debug=0

if [ "$1" == -d ]; then
  shift
  debug=1
fi

pkg=$1
if [ "$pkg" = "" -o ! -e "$pkg" ]; then
   echo "no package supplied" 1>&2
   exit 1
fi

leadsize=96
o=`expr $leadsize + 8`
set `od -j $o -N 8 -t u1 $pkg`
if [ $debug != 0 ];then
  for p in {2..9}; do
    echo "\$$p = ${!p}"
  done
fi
il=`expr 256 \* \( 256 \* \( 256 \* $2 + $3 \) + $4 \) + $5`
dl=`expr 256 \* \( 256 \* \( 256 \* $6 + $7 \) + $8 \) + $9`

sigsize=`expr 8 + 16 \* $il + $dl`

if [ $debug != 0 ]; then
  echo "il=$il"
  echo "dl=$dl"
  echo "sigsize = $sigsize"
fi
o=`expr $o + $sigsize + \( 8 - \( $sigsize \% 8 \) \) \% 8 + 8`
set `od -j $o -N 8 -t u1 $pkg`
if [ $debug != 0 ];then
  for p in {2..9}; do
    echo "\$$p = ${!p}"
  done
fi
il=`expr 256 \* \( 256 \* \( 256 \* $2 + $3 \) + $4 \) + $5`
dl=`expr 256 \* \( 256 \* \( 256 \* $6 + $7 \) + $8 \) + $9`

hdrsize=`expr 8 + 16 \* $il + $dl`
if [ $debug != 0 ]; then
  echo "il=$il"
  echo "dl=$dl"
  echo "hdrsize = $hdrsize"
fi
o=`expr $o + $hdrsize`

[ $debug != 0 ] && echo "dd if=$pkg ibs=$o skip=1"
dd if=$pkg ibs=$o skip=1 2>/dev/null | gunzip > ${pkg%.rpm}.cpio
