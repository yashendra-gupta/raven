#!/bin/bash

# For notify-send to work, set DBUS_SESSION_BUS_ADDRESS
# Refer
#   - https://stackoverflow.com/a/33723614
#   - https://askubuntu.com/questions/926626/how-do-i-fix-warning-command-substitution-ignored-null-byte-in-input/926695#926695
# Note: Desktop environment for  KDE is dolphin and for GNOME it is nautilus
# THIS DOES NOT WORK IF DOLPHIN IS NOT OPENED
#username=$(/usr/bin/whoami)
#pid=$(pgrep -u $username dolphin)
#dbus=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ | tr '\0' '\n' | sed 's/DBUS_SESSION_BUS_ADDRESS=//' )
#export DBUS_SESSION_BUS_ADDRESS=$dbus


# This is required because crontab does not have DBus information.
# Below line will look for ~/.dbus/Xdbus for DBus information written by script "/etc/profil.d/create-dbus-info.sh"
if [ -r ~/.dbus/Xdbus ]; then
  source ~/.dbus/Xdbus
fi

if  [ -d /opt/development/raven ]
then
        echo "Directory exist...will fetch"
        cd /opt/development/raven

        FETCH=/usr/bin/git git fetch --all

        diffCount=$(git rev-list --count $RAVEN_UPDATE_BRANCH..origin/$RAVEN_UPDATE_BRANCH)
        printf "\033[0;32mRaven updates : $diffCount new updates available !!\n"
        notify-send -t 10000 --hint=string:desktop-entry:org.kde.dolphin "Raven Updates" "$diffCount new update(s) available"
else
        echo "cloning"
        error=/usr/bin/git git clone git@github.com:yashendra-gupta/raven.git
        mv raven /opt/development/
        echo "cloning done"
fi
