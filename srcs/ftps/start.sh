#!/bin/sh

telegraf & 
/usr/sbin/pure-ftpd -j -Y 2 -I 20 -p 21100:21109 -P 192.168.99.113
tail -f /dev/null
