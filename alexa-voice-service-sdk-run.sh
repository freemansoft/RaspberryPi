#!/bin/bash

if [ ! -f "$HOME/avs-device-sdk/startsample.sh" ] ;
then
    echo "You have to set this.  Try alexa-voice-service-sdk-setup.sh"
    exit 1
fi

# we couldn't do this in the build process because of the script that is supplied as part of this
# edit config file
cd $HOME/avs-device-sdk/build/Integration
if ! grep -q "gstreamerMediPlayer" AlexaClientSDKConfig.json; then
    cp AlexaClientSDKConfig.json AlexaClientSDKConfig-$(date -d "today" +"%Y-%m-%d-%H%M%S").json 
    sed -i "s/^{/{\n    \"gstreamerMediaPlayer\":{\n        \"audioSink\":\"alsasink\"\n    },/" AlexaClientSDKConfig.json
fi

# Run the sample
cd $HOME/avs-device-sdk
sudo bash startsample.sh