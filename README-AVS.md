# AWS Voice Service SDK - Alexa 
Download, build and run Amazon Voice Service code and samples.  Wakeword can be enabled.

## Installation and execution scripts scripts
`smart-screen` scripts install/run per [Alexa Smart Screen Install for Raspberry Pi](https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html)
Building on a Raspberry Pi 3 takes **hours**

You must read that guide to enable AVS with your Amazon account and get a config.json API token that you download to ~pi home directory.
| script | purpose |
| - | - |
| alexa-smart-screen-voice-sdk-setup.sh | Installs the [Alexa Voice SDK (AVS) and SamppleApp using screen smart instructions](https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html)  |
| alexa-smart-screen-voice-sdk-run.sh   | Runs the [AVS SampleApp using screen smart instructions](https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html) with wake word enabled |
| alexa-smart-service-sdk-setup.sh | May not work at this time [AVS Sample App](https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/build-the-avs-device-sdk.html)  |
| alexa-smart-service-sdk-run.sh   | May not work at this time [AVS Sample App](https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/build-the-avs-device-sdk.html)|

## AVS Hardware Microphone
The smart-screen voice SDK setup attempts to configure the microphone.  
It supports a USB Microphone I have tested it with AIY Voice Hat. 
You can verify an .asoundrc configuration by using `aplay` and `arecord`
This has been tested with the following:

| Microphone type | virtual card slot | Tested | Succeded |
| - | - | - | - |
| [AIY V1 voice hat on RPi3](https://aiyprojects.withgoogle.com/voice-v1) | 0 | Yes | Yes |
| Logitech Rockband USB microphone on RPi3 | 1 | Yes | Yes |

| Speaker type | virtual card slot | Tested | Succeded |
| - | - | - | - |
| AIY voice hat on RPie3 | 0 | Yes | Yes |
| HDMI Audio Channel | ? | No | N/A |

## Tested O/S 
Currently only tested on Raspberry Pi3 running Google Raspberry Pi Image and Google AIY V1 Voice Hat.
AVS SDK was installed on top of that operating system.

## Script installation
Cloning this repository onto your RPi is simplest way to get these onto your Raspberry Pi.
The scripts will be copied onto the /boot partition of any Raspberry Pi Zero that has ether_gadget enabled via the Powershell Script