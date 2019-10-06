#! /usr/bin/env python3

import argparse
import os
import re
import shutil
import sys
import subprocess
from typing import List


# TODO: How to detect flatpak desktop applications?
DESKTOP_DIRECTORIES = [
    "/usr/share/applications/",
    os.path.expanduser("~/.local/share/applications"),
]


def fzf_launch_options() -> List[str]:
    desktop_search_path = os.path.realpath(__file__)
    return [
        "fzf",
        "--reverse",
        "--prompt", "Run> ",
        "--preview", f"{desktop_search_path} --preview {{}}",
        "--preview-window=bottom:1",
    ]


def main() -> None:
    if not command_exists("fzf"):
        print("fzf is not installed or is not in your $PATH")
        return

    parser = argparse.ArgumentParser()
    parser.add_argument("--debug", action="store_true", default=False)
    parser.add_argument("--preview", required=False)

    options = parser.parse_args()

    desktop_entries = get_all_desktop_entries()

    # Because fzf only knows the Name we are displaying, we need to rely on this
    # same script to map the name back to the correct desktop entry and print its comment
    if options.preview:
        print(desktop_entries[options.preview].get("Comment", ""))
        return

    # Data to feed to fzf
    data = "\n".join(sorted(desktop_entries.keys()))

    result = subprocess.run(
        fzf_launch_options(),
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

    if options.debug is True:
        print(target)
    else:
        subprocess.Popen(
            [launcher] + executable,
            start_new_session=True,
            close_fds=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


def command_exists(command: str) -> bool:
    return shutil.which(command) != None


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
                try_exec = desktop.get("TryExec")

                if try_exec and not command_exists(try_exec):
                    continue

                if name and not no_display:
                    desktop_entries[name] = desktop
    return desktop_entries


def get_desktop(path: str) -> dict:
    required_fields = ["Name", "Exec", "TryExec", "Terminal", "NoDisplay", "Comment", "_path"]

    # It's actually faster reading data all at once
    # Then iterating through the lines and breaking early
    with open(path, "r") as fp:
        data = fp.readlines()

    # Include for potential debugging purposes
    result = {"_path": path}

    # Skip first line containing [Desktop Entry]
    for line in data[1:]:
        # Finding any new section means we should stop
        if re.match(r"\[.+\]", line):
            break

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


# These are special freedesktop defined parameters which we need to remove
# as we are not launching them in any special way (e.g. using a target file)
# see https://developer.gnome.org/desktop-entry-spec/#exec-variables
FIELD_CODES = [
    "%s", "%u", "%U", "%f", "%F", "%d", "%D", "%n", "%N", "%i", "%c", "%k", "%v", "%m"
]


def get_executable(value: str) -> List[str]:
    result = []
    for token in value.split(" "):
        if token not in FIELD_CODES:
            result.append(token)
    return result


if __name__ == "__main__":
    main()
