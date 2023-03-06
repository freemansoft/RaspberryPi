#!/bin/bash
# SPDX-FileCopyrightText: 2022 Joe Freeman joe@freemansoft.com
#
# SPDX-License-Identifier: MIT
#
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

# There is a simple hack in here to create your $HOME/.asoundrc file.
# It picks the highest numbered microphone OF 2.
# I did it that way because I have an AIY HAT and/or a Logitech Rockband USB mic
#
# Defer creating asound until done installing sound packages
create_asound() {
    found_mics=`arecord -l | grep card`
    echo "Found microphones: "
    echo "$found_mics"

    if [ -f "$HOME/.asoundrc" ]
    then
        echo ".asoundrc exists - backing up and replacing"
        cp $HOME/.asoundrc $HOME/.asoundrc-$(date -d "today" +"%Y-%m-%d-%H%M%S")
    fi
    cat > ~/.asoundrc <<- EOF
pcm.!default {
    type asym
    playback.pcm {
        type plug
        slave.pcm "hw:0,0"
    }
    capture.pcm {
        type plug
EOF
    if [[ "$found_mics" == *"card 2:"* ]];
    then
        echo "Found Mic on card 2."
        cat >> ~/.asoundrc <<- EOF
        slave.pcm "hw:2,0"
    }
}
EOF
    elif  [[ "$found_mics" = *"card 1:"* ]];
    then
        echo "Found Mic on Card 1"
        cat >> ~/.asoundrc <<- EOF
        slave.pcm "hw:1,0"
    }
}
EOF
    elif  [[ "$found_mics" = *"card 0:"* ]];
    then
        echo "Found Mic on Card 0"
        cat >> ~/.asoundrc <<- EOF
        slave.pcm "hw:0,0"
    }
}
EOF
    else
        echo "Confused about installed microphones. Can't create .asoundrc"
    fi

}

# run the sample app
cd $HOME/sdk-folder/sdk-build
# refresh ~/.asound
create_asound

# Run trigger keys with debug
#echo "i <enter> to see menu. t <enter> to wake.  q <enter> to quit"
#PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json DEBUG9
# Run trigger wake word without debug
echo "wake word is alexa. i<enter> to see menu q<enter> to quit"
PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json ../third-party/alexa-rpi/models
