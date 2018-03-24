#!/bin/bash
#
# Enable the uart
# enable gadget on Raspberry Pi Zero 
# is rerunable
#

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

uart_enable='enable_uart=1'
dwc2_enable='dtoverlay=dwc2'
load_serial="modules-load=dwc2,g_serial"
load_ether="modules-load=dwc2,g_ether"
boot_config_file="/boot/config.txt"
boot_cmd_file="/boot/cmdline.txt"

if grep -q "$uart_enable" $boot_config_file; then
    echo "uart previously enabled"
else
    grep -qF -- "$uart_enable" $boot_config_file || echo "$uart_enable" >> "$boot_config_file"
    echo "uart enabled"
fi
if grep -qF -- "$dwc2_enable" $boot_config_file; then 
    echo "dtoverlay dwc2 previously enabled"
else
    grep -qF -- "$dwc2_enable" $boot_config_file || echo "$dwc2_enable" >> "$boot_config_file"
    echo "dtoverlay dwc2 enabled"
fi

if grep -q "$load_ether" $boot_cmd_file; then 
    echo "ether gadget already added to cmdline"
else
    sed -i 's/rootwait/rootwait $load_ether/' $boot_cmd_file
    echo "ether gadget appended cmdline"
fi

