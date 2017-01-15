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

# Find out what type of Pi this is
