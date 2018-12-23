#!/bin/bash

read TPdevice <<< $( xinput | sed -nre '/TouchPad/s/.*id=([0-9]*).*/\1/p' )
state=$( xinput list-props "$TPdevice" | grep "Device Enabled" | grep -o "[01]$" )

if [ "$state" -eq '1' ];then
    xinput --disable "$TPdevice" && notify-send -i emblem-nowrite "Touchpad" "Disabled"
else
    xinput --enable "$TPdevice" && notify-send -i input-touchpad "Touchpad" "Enabled"
fi
