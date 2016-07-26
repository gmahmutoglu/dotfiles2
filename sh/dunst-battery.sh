#!/bin/sh
#
## dkeg 2014
## Notifications using dunst for battery alerts

## You're battery config may be different
BATT=/sys/class/power_supply/BAT0
CAPACITY=$(cat $BATT/capacity)
STATE=$(cat $BATT/status)

NOTIF='notify-send'
MSG='Battery level at'
URGENT='Battery level critical!'

## Capture states
STATUSF='Full'
STATUSC='Charging'
STATUSD='Discharging'

case ${STATE} in
    'Full')
        STATE=$STATUSF
        ;;
    'Charging')
        STATE=$STATUSC
        ;;
    'Discharging')
        STATE=$STATUSD
        ;;
esac

## Only show notifications if Discharging
## Only show once battery level below 70
if [ ${STATE} = ${STATUSD} ] ; then
case ${CAPACITY} in
    [0-9])
        ${NOTIF} -u critical "${URGENT}" "${CAPACITY}"%
        ;;
    [1-3]*)
        ${NOTIF} -u critical "${MSG}" "${CAPACITY}"%
        ;;
    [4-6]*)
        ${NOTIF} -u normal "${MSG}" "${CAPACITY}"%
        ;;
esac
fi
