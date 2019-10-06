#! /usr/bin/env python3

import os
import shutil
import sys
import subprocess
from typing import List


# TODO: How to detect flatpak desktop applications?
DESKTOP_DIRECTORIES = [
    "/usr/share/applications/",
    os.path.expanduser("~/.local/share/applications"),
]


def main() -> None:
    if not fzf_exists():
        print("fzf is not installed or is not in your $PATH")
        return

    debug = False
    if len(sys.argv) > 1 and sys.argv[1] == "--debug":
        debug = True

    desktop_entries = get_all_desktop_entries()

    # Data to feed to fzf
    data = "\n".join(sorted(desktop_entries.keys()))

    result = subprocess.run(
        ["fzf", "--reverse", "--prompt", "Run> "],
        stdout=subprocess.PIPE,
        encoding="utf8",
        input=data,
    )

    if result.returncode != 0:
        return

    name = result.stdout.rstrip("\n")
    target = desktop_entries[name]
    executable = get_executable(target["Exec"])
    terminal = target.get("Terminal") == "true"

    if terminal:
        # TODO: This should pick up the default terminal application
        launcher = "kitty"
    else:
        # We need nohup to prevent terminal from remaining open
        # TODO: There might be a more direct way of doing this in python
        launcher = "nohup"

    if debug is True:
        print(target)
    else:
        subprocess.Popen(
            [launcher] + executable,
            start_new_session=True,
            close_fds=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


def fzf_exists() -> bool:
    return shutil.which("fzf") != None


def get_all_desktop_entries() -> dict:
    desktop_entries = {}
    for directory in DESKTOP_DIRECTORIES:
        for root, dirs, files in os.walk(directory):
            for entry in files:
                if not entry.endswith(".desktop"):
                    continue

                desktop = get_desktop(os.path.join(root, entry))

                name = desktop.get("Name", "")
                no_display = desktop.get("NoDisplay") == "true"
                if name and not no_display:
                    desktop_entries[name] = desktop
    return desktop_entries


def get_desktop(path: str) -> dict:
    required_fields = ["Name", "Exec", "Terminal", "NoDisplay", "Comment"]

    # It's actually faster reading data all at once
    # Then iterating through the lines and breaking early
    with open(path, "r") as fp:
        data = fp.readlines()

    # Include for potential debugging purposes
    result = {"_path": path}
    for line in data:
        if "=" not in line:
            continue

        tokens = line.split("=")
        field = tokens[0]
        value = "=".join(tokens[1:])

        # Only bother populating the fields that matter
        if field in required_fields:
           result[field] = value.rstrip("\n")

        if result.keys() == required_fields:
            break

    return result


def get_executable(value: str) -> List[str]:
    result = []
    for token in value.split(" "):
        if token not in ("%s", "%u", "%f"):
            result.append(token)
    return result


if __name__ == "__main__":
    main()
