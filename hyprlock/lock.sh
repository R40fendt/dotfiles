#!/bin/bash

kill -STOP $(pidof mpvpaper)

hyprlock

kill -CONT $(pidof mpvpaper)
