This project originally started as tooling to configure a Raspberry Pi Zero as an ethernet gadget to simplify Pi Zero software development. It now contains a couple realitively unrelated sets of tools

[Steps on your PC](./README-Provision-and-EtherGadget.md)
1. Create an SD card and provision tools onto it.  
1. Enable SSH and Wifi and possibly the Rasbery pi Supplement

[Steps on your Raspberry Pi](./README-Utility-Scripts.md) 

The .sh scripts in this project should be available to you on your new Pi in /boot.  They will have been copied to the new Raspberry Pi.

1. Host name
1. Wireless firewall lock down

## Documentation 

| Available Readme files | Target Machine |
| -- | -- |
| [Enable SSH.  Enable Wifi Supplicant. ](./README-Provision-and-EtherGadget.md) | All - Fresh OS SD cards |
| [Raspberry Pi Zero Ethernet Gadget - use networking over USB](./README-Provision-and-EtherGadget.md) | Raspberry Pi Zero - Fresh SD cards|
| [AWS AVS SDK and Sample - Voice recognition using AVS - also Google](./README.AVS.md) | Raspberry Pi 3 and up, Pi Zero |
| [Utilities including custom host names](./README-Utility-Scripts.md) | Machines with Networking |
| [Utilities including wireless firewall restrictions](./README-Utility-Scripts.md) | Machines with wireless |
| [Hacking Aircrack installation](./README-Utility-Scripts.md) | Machines with wireless |

![Script Flow](./images/Script-Flow.png)