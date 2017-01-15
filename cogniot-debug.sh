#!/bin/bash

# 
# 
# Script to report on and.or configure R-Pi GPIO ports for use with 
#  Bostin Technology CognIoT range of devices.
#
#
# Copyright (C) 2017 Bostin Technology - All Rights Reserved



# Revision History
#	Version		Date			Details
#   =========	=============	========================================
#	1.0			8-Jan-2017		Initial release
#
#
#
#
#

set -o errexit -o nounset -o noclobber -o pipefail

# Variable declarations
SERIALID=`fgrep Serial  /proc/cpuinfo | head -1 | awk '{ print $3 }'`
OUTFILE=/tmp/$SERIALID


# Functions

# =============================     Main part of script


if [ -d $OUTFILE ]
then
	rm -rf $OUTFILE
	mkdir $OUTFILE
else 
	mkdir $OUTFILE
fi

touch $OUTFILE/sysconfig.txt
touch $OUTFILE/installed_pkgs.txt
touch $OUTFILE/pip_pkgs.txt
touch $OUTFILE/pip3_pkgs.txt
touch $OUTFILE/type.txt
touch $OUTFILE/gpio.config
touch $OUTFILE/devices.txt


# Check to see if the "wiringpi" package is installed.
#  if not, install it

if [ $(dpkg-query -W -f='${Status}' wiringpi 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install wiringpi;
fi



echo `uname -a ` >>$OUTFILE/sysconfig.txt

echo `dpkg-query -W ` >>$OUTFILE/installed_pkgs.txt
echo `pip list ` >>$OUTFILE/pip_pkgs.txt
echo `pip3 list ` >>$OUTFILE/pip3_pkgs.txt


gpio -v  >>$OUTFILE/type.txt

gpio readall >>$OUTFILE/gpio.config

cp /boot/config.txt  $OUTFILE/

cp /boot/cmdline.txt $OUTFILE/

echo `ls -l /dev/ser*` >>$OUTFILE/devices.txt


tar -czf COGNIOT_DEBUG.tar.gz -C /tmp $SERIALID

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " "
echo " Please email the file COGNIOT_DEBUG.tar.gz to CognIoT Support   "
echo " and we will get back to you as soon as possible."
echo " "
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

rm -rf $OUTFILE

