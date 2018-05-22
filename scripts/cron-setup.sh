#!/usr/bin/env bash

touch /var/log/cron.log 

cronfile=/etc/crontabs/root
echo "" > $cronfile
for cronvar in ${!CRON_*}; do
    cronvalue=${!cronvar}
    echo "$cronvalue >> /var/log/cron.log 2>&1" >> $cronfile
done
echo "" >> $cronfile

crond