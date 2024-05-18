#!/bin/bash

# wait for 5 minutes and kill processes related to software update pop up
sleep 300
killall -15 DiscoverNotifier pamac-tray-plasma msm_kde_notifier

# copy raven version file
cp /opt/development/raven/version.txt $RAVEN_HOME/version.txt