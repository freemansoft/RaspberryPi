# RaspberryPi Scripts
Various Raspberry Pi Scripts and programs. Some of these are [discussed on my blog](joe.blog.freemansoft.com)

## create_custom_host.sh ##
The default DNS name for a raspberry pi is `raspberrypi.local`  
This is obviously an issue if you have more than on Raspberry Pi on your network.
`create_custom_host.sh` can be used when setting up more than one Raspberry Pi for the same network.  The hostname change happens **immediately**. 

Operates two different ways
1. Sets the hostname to be unique by including the CPUID.
    1. Write down the name prior to restart or you won't be able to find the machine in DNS / mDNS. 
1. Can also set the hostname from a hostname mapping file.
    1. Create a file _PiNames.txt_ with a list of host names and CPUIDs. 
    1. The script will pull the host name from the matching row in the file


## enable_uart_g_ether.sh ##
Enables the USB ethernet gadget feature on a Raspberry Pi Zero (W, 1.3...). This makes the the Raspberry Pi Zero appear as a new network when plugged into a PC/Mac USB port.  It shows up as a _raspberrypi.local_ on a _169.x.x.x_ network.

## enable_ssh_restrict_interface.sh ##
Enables SSH but blocks connections on **non USB0** interfaces. No other service/port is affected. All inbound services other than SSH are available on all interfaces. Lets you ssh into a **Raspberry Pi Zero** that has been configured as a network gadget while blocking WAN/LAN connections.

### Impact on SSH connectivity
A computer connected to the Raspberry Pi Zero via ethernet or wi-fi cannot SSH into the R-Pi.

A computer connected to the Raspberry Pi Zero via USB Ethernet gadget can SSH into the R-Pi as long as it uses the LAN interface USB0.  Connections via other interfaces will be blocked like in the previous scenario 

SSH connectivity after will be the following after running the script.

| SSH | wlan0    | eth0    | usb0    |
|-----|----------|---------|---------|
|IPV4 | disabled | enabled | enabled |
|IPV6 | disabled | enabled | enabled | 

eth0 is left enabled because we assume hardware network is trusted and protected by firewall.  You can change flag in the file to block eth0

### Impact on usability of mDNS ###
mDNS/Bonjour may return all of the IPV4/IPV6 addresses for all interfaces. You must SSH into the Raspberry Pi Zero using one of the addresses for the USB0. You will have to look up the IPV4/IPV6 addresses and determine which ones are available.

Use the **dns-sd** command.  The following command returns all addresses for a Raspberry-Pi that has two network interfaces: _wlan0_ and _usb0_ (gadget). You can see the two interfaces in the interface (_if_) column.

* dns-sd -G v4v6 \<hostname\>.local 
```
C:\Users\joe>dns-sd -G v4v6 pi-520863f1.local
Timestamp     A/R Flags if Hostname                  Address                                      TTL
21:57:00.586  Add     3 20 pi-520863f1.local.        FE80:0000:0000:0000:1B31:2156:F706:AFB8%ethernet_32785 120
21:57:00.590  Add     2 20 pi-520863f1.local.        169.254.107.129                              120
21:57:00.674  Add     3 13 pi-520863f1.local.        FE80:0000:0000:0000:1BE6:83EB:185C:D72F%ethernet_32777 120
21:57:00.676  Add     2 13 pi-520863f1.local.        192.168.1.3                                  120
```
My home network is _192.168.1.x_ and that the mDNS network is usually _169.254.x.x_ . SSH, for the host in the example, is only be available on the 169 network.  

Only SSH is restricted. This means you can
* _SSH_ into any of the address on _IF 20_. 
* Connect to any non SSH service, like a web server, on all returned addresses (all interfaces).

#### Notes
* The host in the example command had its hostname set with _create\_custom\_host.sh_
* **dns-sd** 
  * You **must include** the _.local_ when running _dns-sd_ with a hostname.
  * SSH, mDNS and the routing can take a while to go live on a Raspberry Pi Zero connected to a PC. 
  * DNS may show quickly. The routing seems to take a while.  
  * I've seen it take several minutes to be able to ssh on the 169.168 network addresses. I found it easiest to ping the box until it replies. Initially the ping will timeout and then start seeing replies.
  * You may not see slow/routing or routing timeouts if the USB connection is the only route between your PC and the Raspberry Pi Zero in with ether gadget.


