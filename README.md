This project originally started as tooling to configure a Raspberry Pi Zero as an ethernet gadget to simplify Pi Zero software development. It now contains a couple realitively unrelated sets of tools

# ISSUES
1. This restores the legacy default user. That is a security risk. Remove or replace userconf.txt to if you do not want this behavior.

# Setup

[Steps on your PC](./README-Provision-and-EtherGadget.md)
Use these scripts to copy scripts to the SD card and make configuration changes required to enable the USB network gadget
1. Create an SD card and provision tools onto it.  
1. Remove and re-insert the sd card to mount it in windows
1. Run the Enable-Ethernet-Gadget.ps1
    1. Enables SSH and Wifi and possibly the Rasbery pi Supplement
    1. Enables the Ethernet gadget for Ethernet over USB
    1. Copies scripts to /boot
1. Eject and put card in Raspberry pi and boot

[Steps on your Raspberry Pi](./README-Utility-Scripts.md) 
The .sh scripts in this project should be available to you on your new Pi in /boot.  They will have been copied to the new Raspberry Pi.
1. Creates a unique hostname based on ethernet 
1. Wireless firewall lock down to only allow ssh over hardwire

## This repository

| Available functionality with files | Target Machine | environment |
| -- | -- | -- |
| [Enable SSH.  Enable Wifi Supplicant. ](./README-Provision-and-EtherGadget.md) | All - Fresh OS SD cards | OS Card Burning |
| [Raspberry Pi Zero Ethernet Gadget - use networking over USB](./README-Provision-and-EtherGadget.md) | Raspberry Pi Zero - Fresh SD cards| OS Card Burning |
| [AWS AVS SDK and Sample - Voice recognition using AVS - also Google](./avs/README.AVS.md) | Raspberry Pi 3 and up, Pi Zero | On the Pi |
| [Utilities including custom host names](./README-Utility-Scripts.md) | Machines with Networking | On the Pi |
| [Utilities including wireless firewall restrictions](./README-Utility-Scripts.md) | Machines with wireless | On the Pi |
| [Hacking Aircrack installation](./README-Utility-Scripts.md) | Machines with wireless | On the Pi |

![Script Flow](./images/Script-Flow.png)

## Videos on YouTube 

1. [Scripted Install of Amazon Voice Services on a Raspberry Pi](https://youtu.be/qLfiqOiEKPY)
1. [Running Amazon AVS on a Raspberry Pi with Google AIY Hardware](https://youtu.be/00nmUphjxog)
1. [Remote development on a headless Raspberry Pi with Visual studio Code](https://youtu.be/x69x4bW9OyM)
1. [Build a Raspberry Pi image for the Ethernet Gadget](https://youtu.be/Ci_mZJoS3tg)

## Other References
1. [Setting up the Raspberry Pi Zero without HDMI or OTG](http://joe.blog.freemansoft.com/2018/03/setting-up-raspberry-pi-zero-without.html)
1. [Protecting the Pi: Restricting SSH to hardwire connections](http://joe.blog.freemansoft.com/2018/03/protecting-pi-restricting-ssh-to-usb.html)
1. [Minor hints on the Windows RNDIS driver](https://joe.blog.freemansoft.com/2022/11/installing-rndis-driver-on-windows-11.html)
