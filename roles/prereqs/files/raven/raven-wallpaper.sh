#!/bin/bash

# doing this as these env variables are not during ansible task 
declare -r RAVEN_HOME="${RAVEN_HOME="/opt/raven"}"
declare -r RAVEN_WALLPAPER="${RAVEN_WALLPAPER="$RAVEN_HOME/wallpaper"}"
declare -r RAVEN_LOG="${RAVEN_LOG="$RAVEN_HOME/log"}"

declare WALLPAPER_FILE_NAME=$1;
if [ -z "$1" ]
  then
    WALLPAPER_FILE_NAME="raven-wallpaper-cloud.png";
fi

declare -r LOG_FILE="$RAVEN_LOG/raven_wallpaper.log";
declare -r WALLPAPER_PATH="$RAVEN_WALLPAPER/$WALLPAPER_FILE_NAME";

echo "For debugging, refer log file $LOG_FILE";
echo "Set wallpaper $WALLPAPER_PATH" >> $LOG_FILE;

# using date as workaround for issue where wallpaper changes on fast run but afterwards does not change.
# Not sure about the root cause...may be its caching previous image somewhere
# hence, generating unique filename by suffixing date
declare -r MODIFIED_WALLPAPER_PATH="/tmp/raven-wallpaper-modified$(date +"%s").png";

declare -r RAVEN_VERSION_FILE_PATH=$RAVEN_HOME/version.txt;
declare -r RAVEN_BUILD=$(sed -n '2p' $RAVEN_VERSION_FILE_PATH | cut -d " " -f 2,3);
declare -r RAVEN_AUTHOR=$(sed -n '3p' $RAVEN_VERSION_FILE_PATH | cut -d " " -f 2,3);

#Careful with double quotes in these variable and there usage in convert command
declare -r buildInfoFormat="$RAVEN_BUILD";
declare -r authorInfoFormat="by $RAVEN_AUTHOR";

echo "buildInfoFormat=$buildInfoFormat and authorInfoFormat=$authorInfoFormat" >> $LOG_FILE;

echo "Modifying wallpaper image to have -> buildInfoFormat=$buildInfoFormat and authorInfoFormat=$authorInfoFormat" >> $LOG_FILE;

# colors
declare color_1="#000";
declare color_2="#222";

if  [[ $WALLPAPER_FILE_NAME == *"dark"* ]]; then
    echo "Wallpaper seems to be dark, using color scheme for dark" >> $LOG_FILE;
    color_1="#ccc";
    color_2="#aaa";
fi

convert -pointsize 25 -fill $color_1 -gravity center -annotate -60+0 'Raven' $WALLPAPER_PATH $MODIFIED_WALLPAPER_PATH;
convert -pointsize 15 -fill $color_2 -gravity center -annotate +50+5 "$authorInfoFormat" $MODIFIED_WALLPAPER_PATH $MODIFIED_WALLPAPER_PATH
convert -pointsize 12 -fill $color_2 -gravity center -annotate +10+30 "$buildInfoFormat" $MODIFIED_WALLPAPER_PATH $MODIFIED_WALLPAPER_PATH

echo "Modified wallpaper image to have -> buildInfoFormat=$buildInfoFormat and authorInfoFormat=$authorInfoFormat" >> $LOG_FILE;

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var Desktops = desktops();
    print (Desktops);
    for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
        d.writeConfig('Image', '$MODIFIED_WALLPAPER_PATH')
}"


echo "Setting wallpaper with image $MODIFIED_WALLPAPER_PATH" >> $LOG_FILE;


echo "Deleting image $MODIFIED_WALLPAPER_PATH" >> $LOG_FILE;

rm $MODIFIED_WALLPAPER_PATH


echo "Deleted image $MODIFIED_WALLPAPER_PATH" >> $LOG_FILE;
