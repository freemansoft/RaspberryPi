#https://developer.amazon.com/en-US/docs/alexa/avs-device-sdk/raspberry-pi.html

cd /home/pi/
mkdir sdk-folder

cd sdk-folder
mkdir sdk-build sdk-source third-party sdk-install db 

cd /home/pi/
sudo apt-get update


sudo apt-get -y install \
 git gcc cmake build-essential libsqlite3-dev libcurl4-openssl-dev libfaad-dev \
 libssl-dev libsoup2.4-dev libgcrypt20-dev libgstreamer-plugins-bad1.0-dev \
 gstreamer1.0-plugins-good libasound2-dev doxygen


# cd /home/pi/sdk-folder/third-party
#  wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
#  tar zxf pa_stable_v190600_20161030.tgz

#  cd portaudio
#  ./configure --without-jack

cd /home/pi/sdk-folder/sdk-source
 git clone --single-branch git://github.com/alexa/avs-device-sdk.git

cd /home/pi/sdk-folder/third-party
 git clone git://github.com/Sensory/alexa-rpi.git

cd /home/pi/sdk-folder/third-party/alexa-rpi/bin/
 ./license.sh

  cd /home/pi/sdk-folder/sdk-build
 cmake /home/pi/sdk-folder/sdk-source/avs-device-sdk \
 -DSENSORY_KEY_WORD_DETECTOR=ON \
 -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=/home/pi/sdk-folder/third-party/alexa-rpi/lib/libsnsr.a \
 -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=/home/pi/sdk-folder/third-party/alexa-rpi/include \
 -DGSTREAMER_MEDIA_PLAYER=ON \
 -DPORTAUDIO=ON \
 -DPORTAUDIO_LIB_PATH=/home/pi/sdk-folder/third-party/portaudio/lib/.libs/libportaudio.a \
 -DPORTAUDIO_INCLUDE_DIR=/home/pi/sdk-folder/third-party/portaudio/include