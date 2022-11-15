This project originally started as tooling to configure a Raspberry Pi Zero as an ethernet gadget to simplify Pi Zero software development. It now contains a couple realitively unrelated sets of tools

[Steps on your PC](./README-Provision-and-EtherGadget.md)
1. Create an SD card and provision tools onto it.  
1. Enable SSH and Wifi and possibly the Rasbery pi Supplement

[Steps on your Raspberry Pi](./README-Utility-Scripts.md) 

The .sh scripts in this project should be available to you on your new Pi in /boot.  They will have been copied to the new Raspberry Pi.

1. Host name
1. Wireless firewall lock down

## This repository

| Available functionality with files | Target Machine |
| -- | -- |
| [Enable SSH.  Enable Wifi Supplicant. ](./README-Provision-and-EtherGadget.md) | All - Fresh OS SD cards |
| [Raspberry Pi Zero Ethernet Gadget - use networking over USB](./README-Provision-and-EtherGadget.md) | Raspberry Pi Zero - Fresh SD cards|
| [AWS AVS SDK and Sample - Voice recognition using AVS - also Google](./README.AVS.md) | Raspberry Pi 3 and up, Pi Zero |
| [Utilities including custom host names](./README-Utility-Scripts.md) | Machines with Networking |
| [Utilities including wireless firewall restrictions](./README-Utility-Scripts.md) | Machines with wireless |
| [Hacking Aircrack installation](./README-Utility-Scripts.md) | Machines with wireless |

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
