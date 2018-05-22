#!/usr/bin/env bash

# Set supervisord to output all logs to stdout
if echo "$DEBUG" | grep -sqE "true|TRUE|y|Y|yes|YES|1"; then
    sed -e 's/loglevel=info/loglevel=debug/' -i /etc/supervisord.d/*
fi

exec /usr/bin/supervisord -c /etc/supervisord.conf