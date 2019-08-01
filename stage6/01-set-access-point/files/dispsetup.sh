#!/bin/sh
if grep -q okay /proc/device-tree/soc/v3d@7ec00000/status 2> /dev/null || grep -q okay /proc/device-tree/soc/firmwarekms@7e600000/status 2> /dev/null ; then
if xrandr --output HDMI-1 --primary --mode 640x480 --rate 59.94 --pos 0x0 --rotate normal --dryrun ; then 
xrandr --output HDMI-1 --primary --mode 640x480 --rate 59.94 --pos 0x0 --rotate normal
fi
fi
exit 0