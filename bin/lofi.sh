#! /bin/bash

# lofi is a fzf wrapper script for copying passwords from the password
# store folder.
# It is named mockingly after "rofi" due to how simple it is

set -e

PASSWORD_STORE="$HOME/.password-store"
ALL_ITEMS="$(find "$PASSWORD_STORE" -name "*.gpg" -printf "%P\n")"

result="$(echo "$ALL_ITEMS" | fzf --reverse --prompt "Password> ")"

pass "${result/.gpg/}" | head -1 | nohup wl-copy --paste-once 2>/dev/null

# Show this in the background in case the GPG password prompt is shown
echo "Unlock your password now"

notify-send --app-name=pass \
"Password Store" \
"Copied <b>$result</b> to clipboard
Password will only paste ONCE"
