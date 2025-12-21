#!/bin/bash

/home/jonas/Videos/start-background.sh &

sleep 1

kill -STOP $(pidof mpvpaper)


# Sperrbildschirm starten
hyprlock

# Nach dem Entsperren mpvpaper wieder starten
kill -CONT $(pidof mpvpaper) 

