#!/bin/bash
# cannot run headless unless pipe "YES" in for license agreement
#

default_config_file_name="config.json"

if [ $(id -u) -eq 0 ]
then
    echo "Please do not run as root"
    exit 1
fi

cd ~pi
ls $default_config_file_name

if [ ! -f "$default_config_file_name" ] ;
then
    echo "Create config.json using the Amazon portal https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/input-avs-credentials.html"
    exit 1
fi

# verify audio is working prior to install
aplay /usr/share/sounds/alsa/Front_Center.wav

# cannot run headless
wget https://raw.githubusercontent.com/alexa/avs-device-sdk/master/tools/Install/setup.sh \
wget https://raw.githubusercontent.com/alexa/avs-device-sdk/master/tools/Install/genConfig.sh \
wget https://raw.githubusercontent.com/alexa/avs-device-sdk/master/tools/Install/pi.sh

# could pipe in yes for this let it pick its own serial number or provide one 
#sudo bash setup.sh config.json -s 123456
sudo bash setup.sh config.json
