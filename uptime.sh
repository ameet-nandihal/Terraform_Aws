#!/bin/sh

up_time=`uptime | cut -f2 -d " "`

echo "This machine is up since "$up_time > /tmp/uptime.txt
