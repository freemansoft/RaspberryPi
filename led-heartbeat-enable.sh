#!/bin/bash
# Change the behavior of the status led to be a pattern
led_trigger="heartbeat"
led_trigger_modprobe="modprobe ledtrig_heartbeat"

if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# it is weird but it is leds/leds as of 2020/11
rc_local_orig="^exit 0"
rc_local_target="# Blink status LED in heartbeat pattern\n$led_trigger_modprobe\necho $led_trigger > /sys/devices/platform/leds/leds/led0/trigger\n\nexit 0\n"
if ! grep -q "$led_trigger" /etc/rc.local; then
  echo "Enabling $led_trigger style led blinking via rc.local"
  sed -i "s|$rc_local_orig|$rc_local_target|g" /etc/rc.local
else 
  echo "Hearbeat style led blinking via rc.local already enabled"
fi
