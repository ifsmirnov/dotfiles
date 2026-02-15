#!/bin/bash

exe_by_pid() {
    basename $(readlink /proc/$1/exe)
}

target=""

if [ $# -gt 0 ]; then
    target=$1
else
    if [ "$(xdotool getwindowfocus getwindowname)" = "Guake!" ]; then
        target="Telegram"
    else
        target="Guake"
    fi
fi

# echo "Target = $target"

if [ "$target" = 'Guake' ]; then
    pick() {
        [ "$2" = "Guake!" ]
    }
elif [ "$target" = 'Telegram' ]; then
    pick() {
        [ "$1" = "Telegram" ]
    }
fi

wmctrl -lp | while read id _ pid _ title; do
    exe=$(exe_by_pid $pid)
    echo "ID: '$id', PID: '$pid', EXE: '$exe', DESC: '$title'"
    if pick $exe $title; then
        echo "    picking!"
        wmctrl -ia $id
    fi
done
