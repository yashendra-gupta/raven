#!/bin/bash

# copy raven version file
sleep 300
cp /opt/development/raven/version.txt /opt/raven/version.txt
/opt/raven/bin/raven-wallpaper.sh


# Note, this work should be in the end
# wait for 5 minutes and kill processes related to software update pop up
sleep 300
killall -15 DiscoverNotifier pamac-tray-plasma msm_kde_notifier
