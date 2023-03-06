#!/bin/bash
# SPDX-FileCopyrightText: 2022 Joe Freeman joe@freemansoft.com
#
# SPDX-License-Identifier: MIT
#

# Created 2018-03-20 http://joe.blog.freemansoft.com
# derived from 2017-08-18 https://raspberrypi.stackexchange.com/questions/42145/raspberry-pi-hardware-id
# script to set Pi hostname based on MAC (or Serial number)
# This script should be run as root (or with sudo) to change names
# If run by a user it will report changes, but will NOT implement them

# Creates a unique name using the CPUID. This is the as the MAC when one exists
# Works for PiB (all models), Pi2, Pi3, PiZeroW with on board networking

# change this variable to change the beginning of the hostname
HOSTNAME_PREFIX="pi"
PDIR="$(dirname "$0")"  # directory containing script
CURRENT_HOSTNAME=$(cat /etc/hostname)
echo "Current Name" $CURRENT_HOSTNAME
# NOTE the last 6 bytes of MAC and CPUID are identical
if [ -f $PDIR"/PiNames.txt" ]; then
    # If you want to specify hostnames create a file PiNames.txt with MAC hostname list e.g.
    # b8:27:eb:01:02:03 MyPi
    # Scan the various network interfaces
    if [ -e /sys/class/net/eth0 ]; then
        MAC=$(cat /sys/class/net/eth0/address)
    elif [ -e /sys/class/net/enx* ]; then
        MAC=$(cat /sys/class/net/enx*/address)
    else
        MAC=$(cat /sys/class/net/wlan0/address)
    fi
    echo "Looking in PiNames.txt for MAC " $MAC
    NEW_HOSTNAME=$(awk /$MAC/' {print $2}' $PDIR"/PiNames.txt")
    if [ -z "$NEW_HOSTNAME" ]; then
        echo "Name not found in colocated PiNames.txt. Aborting"
        exit 1
    else
        echo "Using name found in PiNames.txt " $NEW_HOSTNAME
    fi
else
    CPUID=$(awk '/Serial/ {print $3}' /proc/cpuinfo | sed 's/^0*//')
    echo "CPUID" $CPUID
    NEW_HOSTNAME="$HOSTNAME_PREFIX""-""$CPUID"
    echo "Constructed name using CPUID" $NEW_HOSTNAME
fi

if [ "$NEW_HOSTNAME" = "$CURRENT_HOSTNAME" ]; then
    echo "Name already set"
else
    echo "Setting Name" $NEW_HOSTNAME
    echo $NEW_HOSTNAME > /etc/hostname
    sed -i "/127.0.1.1/s/$CURRENT_HOSTNAME/$NEW_HOSTNAME/" /etc/hosts
    # change it without waiting for a restart
    hostname $NEW_HOSTNAME
fi
