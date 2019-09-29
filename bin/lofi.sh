#! /bin/bash

# lofi is a fzf wrapper script for copying passwords from the password
# store folder.
# It is named mockingly after "rofi" due to how simple it is

set -e

PASSWORD_STORE="$HOME/.password-store"
result="$(find "$PASSWORD_STORE" -name "*.gpg" -printf "%P\n" | fzf --layout reverse)"

pass "${result/.gpg/}" | head -1 | nohup wl-copy --paste-once

notify-send --app-name=pass "Password Store" "Copied $result to clipboard"
