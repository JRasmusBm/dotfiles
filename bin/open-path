#!/usr/bin/env python

import os
from sys import argv
import platform
from pathlib import Path


from subprocess import run


def get(command):
    return run(command, capture_output=True).stdout.decode("utf-8")


def main():
    path = argv[1]

    if path.startswith("http"):
        if platform.system() == "Darwin":
            run(["open", path])
        else:
            run(["xdg-open", path])
        return

    if path.startswith("git@github.com"):
        run(["git-open", path.split(":")[1][:-4]])
        return

    path_components = path.split(":")
    raw_file_path = path_components[0]
    if Path(raw_file_path).exists():
        file_path = raw_file_path 
    else:
        current_path = Path(".")
        file_path = None
        while os.path.dirname(current_path) != str(current_path):
            if (current_path / raw_file_path).exists():
                file_path = current_path / raw_file_path
                break
            current_path = current_path / ".."

    if file_path is None:
        print(f"Cannot find file {raw_file_path}")
        exit(1)

    if len(path_components) > 1:
        run(["nr", f"+{path_components[1]}", "--remote", file_path])
        return

    result = run(["nr", "--remote", file_path])

    if result.returncode != 0:
        print(f"Exited with {result.returncode}")
        print("STDOUT")
        print(result.stdout)
        print("STDERR")
        print(result.stderr)



if __name__ == "__main__":
    main()
    exit(0)
