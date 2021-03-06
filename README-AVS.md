# AWS Voice Service SDK - Alexa 
Download, build and run Amazon Voice Service code and samples.  Wakeword can be enabled.

## Installation and execution scripts scripts
`smart-screen` scripts that install and run an AVS SampleApp per [Alexa Smart Screen Install for Raspberry Pi](https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html)

Building on a Raspberry Pi 3 takes **hours**

You must read and follow the 
[guide to enable AVS with your Amazon account](https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/register-a-product.html#register-your-prototype-and-create-a-security-profile) 
and get a config.json API token that you download to ~pi home directory.
| script | purpose |
| - | - |
| alexa-smart-screen-voice-sdk-setup.sh | Installs the [Alexa Voice SDK (AVS) and SamppleApp using screen smart instructions](https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html)  |
| alexa-smart-screen-voice-sdk-run.sh   | Runs the [AVS SampleApp using screen smart instructions](https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/raspberry-pi.html) with wake word enabled |
| alexa-smart-service-sdk-setup.sh | May not work at this time [AVS Sample App](https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/build-the-avs-device-sdk.html)  |
| alexa-smart-service-sdk-run.sh   | May not work at this time [AVS Sample App](https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/build-the-avs-device-sdk.html)|

You will be prompted on random intervals to provide registration codes for dev environments. 

![Registration Screen](./images/AVS-Device-Registration.png)

## AVS Hardware Microphone
[alexa-smart-screen-voice-sdk-run.sh](./alexa-smart-screen-voice-sdk-run.sh) attempts to configure the microphone via ~/.asoundrc file.  
It supports a USB Microphone I have tested it with AIY Voice Hat. 
You can verify an .asoundrc configuration by using `aplay` and `arecord`
This has been tested with the following:

| Microphone type | virtual card slot | Tested | Succeded |
| - | - | - | - |
| [AIY V1 voice hat on RPi3](https://aiyprojects.withgoogle.com/voice-v1) | 0 | Yes | Yes |
| Logitech Rockband USB microphone on RPi3 on system with Voice Hat | 1 | Yes | Yes |

| Speaker type | virtual card slot | Tested | Succeded |
| - | - | - | - |
| AIY voice hat on RPi3 | 0 | Yes | Yes |
| HDMI Audio Channel | ? | No | N/A |

## Video walkthrough

**Installation and usage on stock RPi with USB mic and audio jack**
[![Walkthroiugh installing AVS on stock RPi3 Hardware](http://img.youtube.com/vi/qLfiqOiEKPY/0.jpg)](https://youtu.be/qLfiqOiEKPY "Video")

**Installation and Usage on a RPi with Google AIY Voice Hat**
[![Walkthrough installing AVS with Google AIY Voice hardware](http://img.youtube.com/vi/00nmUphjxog/0.jpg)](https://youtu.be/00nmUphjxog "Video")


## Example: Devices

### AIY
* Image: aiyprojects-2020-11-20.img.xz
* Google AIY V1 Voice Hat - Internal Sound disabled
```bash
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: sndrpigooglevoi [snd_rpi_googlevoicehat_soundcar], device 0: Google voiceHAT SoundCard HiFi voicehat-codec-0 [Google voiceHAT SoundCard HiFi voicehat-codec-0]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
```
```bash
$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: sndrpigooglevoi [snd_rpi_googlevoicehat_soundcar], device 0: Google voiceHAT SoundCard HiFi voicehat-codec-0 [Google voiceHAT SoundCard HiFi voicehat-codec-0]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
```

Standard Raspberry Pi Audio, USB Mic and Google AIY V1 Voice hat
```bash
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Headphones [bcm2835 Headphones], device 0: bcm2835 Headphones [bcm2835 Headphones]
  Subdevices: 7/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 1: sndrpigooglevoi [snd_rpi_googlevoicehat_soundcar], device 0: Google voiceHAT SoundCard HiFi voicehat-codec-0 [Google voiceHAT SoundCard HiFi voicehat-codec-0]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: sndrpigooglevoi [snd_rpi_googlevoicehat_soundcar], device 0: Google voiceHAT SoundCard HiFi voicehat-codec-0 [Google voiceHAT SoundCard HiFi voicehat-codec-0]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 2: Microphone [Logitech USB Microphone], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
pi@pi-73b4b588:~ $
```

### Buster headless
* Image: Buster
* No monitor, headphones only, USB Logitech Rock Band Mic

```bash
pi@pi-52863f1:~ $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Headphones [bcm2835 Headphones], device 0: bcm2835 Headphones [bcm2835 Headphones]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7

```
```bash
pi@pi-52863f1:~ $ arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: Microphone [Logitech USB Microphone], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

```


## Tested O/S 
Currently only tested on Raspberry Pi3 running Google Raspberry Pi Image and Google AIY V1 Voice Hat.
AVS SDK was installed on top of that operating system.

## Script installation
Cloning this repository onto your RPi is simplest way to get these onto your Raspberry Pi.
The scripts will be copied onto the /boot partition of any Raspberry Pi Zero that has ether_gadget enabled via the Powershell Script