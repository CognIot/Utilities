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
#	1.1			20-Jan-2017		Added extra screen prompts and moved wiringpi and wiringpi_python install to this script
#	1.2         26-Jan-2018     Removed device specific config and added i2c setup
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
echo " CognIoT Configuration Utility ........"
echo " "

#PIREV=`cat /proc/cpuinfo |grep Revision |cut -d' ' -f2`
#case "$PIREV" in

## Raspberry Pi Model 2 v1.1 and v1.2

#a01040)
		#echo "Raspberry Pi Model 2 v1.0........."  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

#a01041)
		#echo "Raspberry Pi Model 2 v1.1. (Sony)........"  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

#a21041)
		#echo "Raspberry Pi Model 2 v1.1 (Sony)........."  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

#a22042)
		
		#echo "Raspberry Pi Model 2 v1.2 (Embest).........."  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

## Raspberry Pi Model 3
#a02082)
		
		#echo "Raspberry Pi Model 3 (Sony).........."  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

#a22082)
		
		#echo "Raspberry Pi Model 3 (Embest).........."  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

#9000c1)
## RPi Zero Wireless
		
		#echo "Raspberry Pi Model Zero Wireless.........."  ;
		#echo "Disabling Serial Terminal..........";
		#sudo raspi-config nonint do_serial 1 ;
		#echo " ";
		#echo "Enabling serial port on GPIO 14 & 15.......";
		#sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt
		#echo ;;

#*) 

	#echo "Sorry - a configuration for your Raspberry Pi does not exist.";
	#echo "Please contact CognIoT support for help";

#esac

echo "Disabling Serial Terminal..........";
sudo raspi-config nonint do_serial 1 ;
echo " ";
echo "Enabling serial port on GPIO 14 & 15.......";
sudo sed -i -e 's/enable_uart=0/enable_uart=1/g' /boot/config.txt

echo "Enabling I2C........"; 
 

if [ $(grep -xc 'i2c-bcm2708' /etc/modules) -eq 0 ];
then
  sudo sh -c "echo 'i2c-bcm2708' >> /etc/modules"
fi

if [ $(grep -xc 'i2c-dev' /etc/modules) -eq 0 ];
then
  sudo sh -c "echo 'i2c-dev' >> /etc/modules"
fi

if [ $(grep -xc 'dtparam=i2c1=on' /boot/config.txt) -eq 0 ];
then
  sudo sh -c "echo 'dtparam=i2c1=on' >> /boot/config.txt"
fi

if [ $(grep -xc 'dtparam=i2c_arm=on' /boot/config.txt) -eq 0 ];
then
  sudo sh -c "echo 'dtparam=i2c_arm=on' >> /boot/config.txt"
fi

if [ -f /etc/modprobe.d/raspi-blacklist.conf ]; then
  sudo sed -i 's/^blacklist spi-bcm2708/#blacklist spi-bcm2708/' /etc/modprobe.d/raspi-blacklist.conf
  sudo sed -i 's/^blacklist i2c-bcm2708/#blacklist i2c-bcm2708/' /etc/modprobe.d/raspi-blacklist.conf
fi
 
echo "checking for i2c-tools"
if [ $(dpkg-query -W -f='${Status}' i2c-tools 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install -y i2c-tools;
else
  echo "Already installed"
fi

echo "Checking for wiring pi"
# Check to see if the "wiringpi" package is installed.
#  if not, install it

if [ $(dpkg-query -W -f='${Status}' wiringpi 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install wiringpi;
else
  echo "Already installed"
fi


echo "Checking for wiring pi python"

# Check to see if the "wiringpi" pip package is installed for python.
#  if not, install it

if [ $(pip3 list 2>/dev/null | grep -c "wiringpi") -eq 0 ];
then
  sudo pip3 install wiringpi;
else
  echo "Already installed"
fi

echo "*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*"
echo " "
echo " In order to make these configuration changes active, please "
echo "  reboot this Raspberry Pi."
echo " "
echo " Type sudo reboot at the command line prompt"
echo " "

