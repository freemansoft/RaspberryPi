#!/bin/bash
# SPDX-FileCopyrightText: 2022 Joe Freeman joe@freemansoft.com
#
# SPDX-License-Identifier: MIT
#
# cannot run headless unless pipe "YES" in for license agreement
#

# assumes in ~
default_config_file_name="config.json"

if [ $(id -u) -eq 0 ]
then
    echo "Please do not run as root"
    exit 1
fi

# assumes in ~
default_config_file_name="config.json"
ls $HOME/$default_config_file_name
if [ ! -f "$HOME/$default_config_file_name" ] ;
then
    echo "Create config.json using the Amazon portal https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/input-avs-credentials.html"
    exit 1
fi

cd $HOME
mkdir $HOME/avs-device-sdk
cd $HOME/avs-device-sdk

# cannot run headless
wget https://raw.githubusercontent.com/alexa/avs-device-sdk/master/tools/Install/setup.sh \
wget https://raw.githubusercontent.com/alexa/avs-device-sdk/master/tools/Install/genConfig.sh \
wget https://raw.githubusercontent.com/alexa/avs-device-sdk/master/tools/Install/pi.sh

# assumes config.json is in $HOME
if [ ! -f /$HOME/config.json ]; then
    echo "This requires a file config.json in the developer's home directory of the one running this script"
fi

cp $HOME/config.json $HOME/avs-device-sdk
sed -i 's/-j2/-j1/g' setup.sh
# could pipe in yes for this let it pick its own serial number or provide one
#sudo bash setup.sh config.json -s 123456
sudo bash setup.sh $HOME/config.json

# Will have some prompts to answer

