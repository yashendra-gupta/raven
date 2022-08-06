# This script will run on user login. It gets DBus information and stores in a file.
#
# This is required because script invoked by crontab don't have DBinformatoion.
# Hence by using this script, other scripts involed by crontab can read DBus information from generated file.


# References -
# https://unix.stackexchange.com/questions/84437/how-do-i-make-my-laptop-sleep-when-it-reaches-some-low-battery-threshold/84438#84438
# https://unix.stackexchange.com/questions/111188/using-notify-send-with-cron/111190#111190
# https://unix.stackexchange.com/questions/162856/is-revealing-dbus-session-bus-address-variable-a-vulnerability

!/bin/sh
touch $HOME/.dbus/Xdbus
chmod 600 $HOME/.dbus/Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus

# Don't use exit, it prevents login
# exit 0
