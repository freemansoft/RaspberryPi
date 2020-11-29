#!/bin/bash
#
# Tested with AIY project speaker and mic running AIY 2020/10

if [ $(id -u) -ne 0 ]
then
    echo "Please run as root"
    exit 1
fi

# probably should cd somewhere
cd /opt
if [ ! -d "$AlexiPi" ] 
then
    echo "Cloning repo"
    git clone https://github.com/alexa-pi/AlexaPi.git
fi

if command -v ufw &> /dev/null
then
    echo "Update ufw: Allow inbound 5050 thet auth server"
    sudo ufw allow 5050
fi

bash ./AlexaPi/src/scripts/setup.sh
systemctl start AlexaPi.service
systemctl status AlexaPi.service
