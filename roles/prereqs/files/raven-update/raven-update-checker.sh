#!/bin/bash

# For notify-send to work, set DBUS_SESSION_BUS_ADDRESS
# Refer - https://stackoverflow.com/a/33723614
# Note: Desktop environment for  KDE is dolphin and for GNOME it is nautilus
username=$(/usr/bin/whoami)
pid=$(pgrep -u $username dolphin)
dbus=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ | sed 's/DBUS_SESSION_BUS_ADDRESS=//' )
export DBUS_SESSION_BUS_ADDRESS=$dbus

if  [ -d /opt/development/raven ]
then
        echo "Directory exist...will fetch"
        cd /opt/development/raven
        /usr/bin/git git fetch --all
        diffCount=$(git rev-list --count main..origin/main)
        echo "Diff Count =  $diffCount"
        notify-send -t 10000  "Raven Updates" "$diffCount new update(s) available"
else
        echo "cloning"
        error=/usr/bin/git git clone git@github.com:yashendra-gupta/raven.git
        mv raven /opt/development/
        echo "cloning done"
fi
