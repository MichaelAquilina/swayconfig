#! /usr/bin/bash
# Display appropriate metadata on waybar

output="$(playerctl metadata -f '[{{status}}]  {{artist}} - {{album}} - {{title}}')"
output="$(printf "$output" | sed 's/\[Playing\]//')"
output="$(printf "$output" | sed 's/\[Paused\]//')"

if [[ "$output" != "[Stopped]"* ]]; then
    printf "$output"
else
    printf "No song playing"
fi
