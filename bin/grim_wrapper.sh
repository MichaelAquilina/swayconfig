#! /usr/bin/bash
location="$HOME/Pictures/$(date "+%Y-%m-%d_%H-%M-%S").png"

if [[ "$1" == "-d" ]]; then
    dimensions="$(slurp -d)"
    grim -g "$dimensions" "$location"
else
    grim "$location"
fi

notify-send "Screenshot saved to $(realpath $location --relative-to=$HOME)"
