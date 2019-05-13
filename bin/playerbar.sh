#! /usr/bin/bash
# Display appropriate metadata on waybar

output="$(playerctl metadata -f '[{{status}}]  <b>{{title}}</b> by <i>{{artist}}</i> from <i>{{album}}</i>')"
output="$(printf "$output" | sed 's/\[Playing\]//')"
output="$(printf "$output" | sed 's/\[Paused\]//')"

if [[ "$output" != "[Stopped]"* ]]; then
    printf "$output"
else
    printf "No song playing"
fi
