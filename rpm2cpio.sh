#!/bin/sh
#
# rpm2cpio.sh: Dump an rpms in cpio format to std out.
#
# Apparently written by Jeff Johnson
#
# Found at https://www.redhat.com/archvies/rpm-list/2003-June/msg00367.html
#
# More or less moderatly changed by me (Adding check for magic numbers, using
# more readable variable names).
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

# Checking the magic number
#
#   The first four bytes in an RPM should be
#      ed ab ee db
#
#   od
#     -j:    Specifies bytes to skip
#     -N:    Specifies counts of bytes to read
#     -A n:  Don't print the address
#

checkMagic() {
  local expected=$1
  local startPos=$2

  local magic=$(od -A n -j $startPos -N 4 -t x1 $pkg)
  if [ "$magic" != " $expected" ]; then
    echo "magic number >$magic< is wrong, expected was $expected"
    exit 1
  fi
}
checkMagic 'ed ab ee db' 0

#
# Checking RPM version
#
if [ $debug != 0 ]; then
  major_minor=$(od -A n -j 4 -N 2 -t u1 $pkg)
  echo "Major minor: $major_minor"
fi

#
# An RPM consists of 4 parts.
# The first part, "Lead", consists of 96 bytes:
#
leadsize=96

startSignature=$leadsize

#
# Read "signature"
#
# The "Lead" is followed by the "signature"
# The signature has the same format as the 3rd section, the "header"
# The signature is identified by a magic number:
checkMagic '8e ad e8 01' $startSignature

#
#  The header than continues with 4 reserved bytes.
#  So, we read startSignature+8 (=4 magic bytes and 4 reserved bytes)
#
#  od:
#     -t u1: Specifies that unsigned decimals of one byte should be dumped
#  set:
#    set positional parameters
o=`expr $leadsize + 8`


set `od -j $o -N 8 -t u1 $pkg`

if [ $debug != 0 ];then
  for p in {2..9}; do
    echo "\$$p = ${!p}"
  done
fi

four256() {
  echo $(expr 256 \* \( 256 \* \( 256 \* $1 + $2 \) + $3 \) + $4 )
}

nofIndexRecords=$(four256 $2 $3 $4 $5) # Number of index records following the header record
sizeStorageArea=$(four256 $6 $7 $8 $9)

sizeHeaderRecord=16
sizeIndexeRecord=16
sizeSignature=$(expr $sizeHeaderRecord + $sizeIndexeRecord \* $nofIndexRecords + $sizeStorageArea)

if [ $debug != 0 ]; then
  echo "sizeSignature = $sizeSignature"
fi

#
#  Reading "Header"
#  The header has the same structure as the signature.
#

startHeader=$(expr $startSignature + $sizeSignature      + \( 8 - \( $sizeSignature \% 8 \) \) \% 8   )
checkMagic '8e ad e8 01' $startHeader

o=$(expr $startHeader + 8)
set `od -j $o -N 8 -t u1 $pkg`
if [ $debug != 0 ];then
  for p in {2..9}; do
    echo "\$$p = ${!p}"
  done
fi

nofIndexRecords=$(four256 $2 $3 $4 $5) # Number of index records following the header record
sizeStorageArea=$(four256 $6 $7 $8 $9)

sizeHeader=$(expr $sizeHeaderRecord + $sizeIndexeRecord \* $nofIndexRecords + $sizeStorageArea )
if [ $debug != 0 ]; then
  echo "il=$il, nofIndexRecords=$nofIndexRecords"
  echo "dl=$dl, sizeStorageArea=$sizeStorageArea"
  echo "sizeHeader = $sizeHeader"
fi
startPayload=$(expr $startHeader + $sizeHeader )


[ $debug != 0 ] && echo "dd if=$pkg ibs=$o skip=1"
dd if=$pkg ibs=$startPayload skip=1 2>/dev/null | gunzip > ${pkg%.rpm}.cpio
