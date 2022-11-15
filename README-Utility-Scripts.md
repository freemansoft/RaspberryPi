These scripts are copied to the /boot partition of any SD card configured by the Pi-Zero ethernet gadget powershell script.
They will need to be manually copied or `git clone...` onto other devices

# Additional scripts copied to boot partition
A set of **optional** utility scripts will have been copied to the boot partition.

## Useful Utilities

These must be run with `sudo`

| | script | purpose |
| - | - | - |
| `sudo /boot/hostname-custom-serial-set.sh` | Recommended | Sets the hostname of the pi to pi-<serial_id>.  Updates /etc/hostname and /etc/hosts |
| `sudo /boot/led-heartbeat-enable.sh`       | Optional | Changes the trigger for the Pi-Zero onboard status led to be a heartbeat pattern |
| `sudo /boot/ufw-firewall-enable.sh`        | Recommended | Enables the firewall blocking all inbound traffic on wlan0 while leaving hardwire eth0 / usb0 open to SSH |

* The `ufw-firewall-enable.sh` script reqiures internet access either via wifi or via connection sharing (tested on mac)

# Air crack experimentation
All of these must be run with _sudo_ 
| | script | purpose |
| - | - | - |
| Speciality  | aircrack-install.sh           | Converts this pi to an aircrack machine with monitor mode |

# Other notes
 You can reduce the O/S update times by uninstalling components. The Raspberry Pi 400 comes with a lot installed. You can save over 2GB of SD card space with:
```bash
sudo apt-get purge wolfram-engine
sudo apt-get autoremove
```