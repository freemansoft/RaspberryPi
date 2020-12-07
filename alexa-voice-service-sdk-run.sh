#!/bin/bash

if [ ! -f "$HOME/avs-device-sdk/startsample.sh" ] ;
then
    echo "You have to set this.  Try alexa-voice-service-sdk-setup.sh"
    exit 1
fi

# Run the sample
cd $HOME/avs-device-sdk
sudo bash startsample.sh