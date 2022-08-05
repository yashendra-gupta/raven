#!/bin/bash

cron_update="* * * * *  raven-update >> /opt/log/raven-update.log"
crontab -l > crontab_tmp
echo "$cron_update" >> crontab_tmp
crontab crontab_tmp
rm crontab_tmp
