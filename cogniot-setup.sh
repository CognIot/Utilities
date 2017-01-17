#!/bin/bash

# 
# 
# Script to configure R-Pi GPIO ports for use with 
#  Bostin Technology CognIoT range of devices.
#
#
# Copyright (C) 2017 Bostin Technology - All Rights Reserved



# Revision History
#	Version		Date			Details
#   =========	=============	========================================
#	1.0			13-Jan-2017		Initial release
#
#
#
#
#
#
set -o errexit -o nounset -o noclobber -o pipefail

# Variable declarations
SERIALID=`fgrep Serial  /proc/cpuinfo | head -1 | awk '{ print $3 }'`
OUTFILE=/tmp/$SERIALID

echo "******************************************************************"
echo " CognIoT Configuration ........"
echo " "

PIREV=`cat /proc/cpuinfo |grep Revision |cut -d' ' -f2`


case "$PIREV" in

# Raspberry Pi Model 2 v1.1 and v1.2

a01040)
		echo "Raspberry Pi Model 2 v1.0........."  ;
		echo "Disabling Serial Terminal..........";
		sudo raspi-config nonint do_serial 1 ;
		echo " ";
		echo "Enabling serial port on GPIO 14 & 15.......";
		sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		echo ;;


a01041)
		echo "Raspberry Pi Model 2 v1.1. (Sony)........"  ;
		echo "Disabling Serial Terminal..........";
		sudo raspi-config nonint do_serial 1 ;
		echo " ";
		echo "Enabling serial port on GPIO 14 & 15.......";
		sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		echo ;;


a21041)
		echo "Raspberry Pi Model 2 v1.1 (Sony)........."  ;
		echo "Disabling Serial Terminal..........";
		sudo raspi-config nonint do_serial 1 ;
		echo " ";
		echo "Enabling serial port on GPIO 14 & 15.......";
		sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		echo ;;


a22042)
		
		echo "Raspberry Pi Model 2 v1.2 (Embest).........."  ;
		echo "Disabling Serial Terminal..........";
		sudo raspi-config nonint do_serial 1 ;
		echo " ";
		echo "Enabling serial port on GPIO 14 & 15.......";
		sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		echo ;;


# Raspberry Pi Model 3
a02082)
		
		echo "Raspberry Pi Model 3 (Sony).........."  ;
		echo "Disabling Serial Terminal..........";
		sudo raspi-config nonint do_serial 1 ;
		echo " ";
		echo "Enabling serial port on GPIO 14 & 15.......";
		sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		echo ;;

a22082)

		
		echo "Raspberry Pi Model 3 (Embest).........."  ;
		echo "Disabling Serial Terminal..........";
		sudo raspi-config nonint do_serial 1 ;
		echo " ";
		echo "Enabling serial port on GPIO 14 & 15.......";
		sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		echo ;;

*) 

	echo "Sorry - a configuration for your Raspberry Pi does not exist.";
	echo "Please contact CognIoT support for help";

esac


echo "*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*"
echo " "
echo " In order to make these configuration changes active, please "
echo "  reboot this Raspberry Pi."
echo " "
echo " Type sudo reboot at the command line prompt"
echo " "

