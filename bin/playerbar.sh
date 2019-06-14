#! /usr/bin/bash
# Display appropriate metadata on waybar

output="$(playerctl metadata -f '<b>{{title}}</b> by <i>{{artist}}</i> from <i>{{album}}</i> <small>({{status}})</small>')"

if [[ "$output" != "[Stopped]"* ]]; then
    printf "$output"
else
    printf "No song playing"
fi
