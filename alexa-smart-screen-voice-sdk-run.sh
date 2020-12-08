#!/bin/bash
#
# https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html
# 
# Runs the Alexa Voice Service SDK that is installed as phase 1 of the Alexa smart screen installation

if [ $(id -u) -eq 0 ]
then
    echo "Please do not run as root"
    exit 1
fi

# assumes in ~
if [ ! -f "$HOME/sdk-folder/sdk-build/SampleApp/src/SampleApp" ] ;
then
    echo "Sample not built.  Have you run alexa-smartscreen-sdk-setup.sh"
    exit 1
fi

echo "t <enter> to wake.  q <enter> to quit"

# run the sample app
cd $HOME/sdk-folder/sdk-build
# Run trigger keys with debug
#PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json DEBUG9
# Run trigger wake word without debug
PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json ../third-party/alexa-rpi/models
