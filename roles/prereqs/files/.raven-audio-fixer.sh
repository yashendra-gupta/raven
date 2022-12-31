#!/bin/bash

declare -r kernelVersion=$(uname -r)
echo "Kernel version is "$kernelVersion

echo "To fix audio issue, Raven needs to install linux-modules-extra-"$kernelVersion
echo "Press (y) to proceed :"
read userConfirmation

if  [[ $userConfirmation != "y" ]]; then
        echo "You aborted the Raven Audio Fixer."
        exit
fi

echo "Installing linux-modules-extra-"$kernelVersion

sudo apt-get install "linux-modules-extra-"$kernelVersion

echo "Installed linux-modules-extra-"$kernelVersion

echo "Configuring the system"
sudo sh -c 'echo "snd-hda-intel" >> /etc/modules'
echo "Configuring done"

echo "Raven need to reboot to reflect the audio fixer effect, Press (y) to proceed :"
read userConfirmation

if  [[ $userConfirmation != "y" ]]; then
        echo "You aborted the Raven Audio Fixer. Audio fix is done but reboot is required to reflect the audio fixer effect."
        exit
fi

sudo reboot