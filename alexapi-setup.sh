#!/bin/bash
#
# Tested with AIY project speaker and mic running AIY 2020/10
#
# I had to boot with a monitor to use localhost to get the Amazon credentials to create a token.
# I could not get amazon credentials to be issued using browser from different machine pointed at Pi:5050
# 
# So I ended up reboot once with HDMI to get redirect browser to work and once to bring actually run device

if [ $(id -u) -ne 0 ]
then
    echo "Please run as root"
    exit 1
fi

# verify audio is working prior to install
aplay /usr/share/sounds/alsa/Front_Center.wav

# probably should cd somewhere
cd /opt
if [ ! -d "$AlexiPi" ] 
then
    echo "Cloning repo"
    git clone https://github.com/alexa-pi/AlexaPi.git
fi

if command -v ufw &> /dev/null
then
    echo "Update ufw: Allow inbound 5050 the auth server"
    sudo ufw allow 5050
fi

# setup.sh actually has to be control-c but the rest of this script runs after
bash ./AlexaPi/src/scripts/setup.sh
#IMPORTANT NOTICE:
#If you use a desktop OS, you HAVE TO set up your system audio so services like AlexaPi can use it too.
#See https://github.com/alexa-pi/AlexaPi/wiki/Audio-setup-&-debugging#pulseaudio
systemctl start AlexaPi.service
systemctl status AlexaPi.service

# verify speaker works after setup
aplay /usr/share/sounds/alsa/Front_Center.wav