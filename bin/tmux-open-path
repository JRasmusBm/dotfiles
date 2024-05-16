#!/usr/bin/env python3

from subprocess import run
import re


def get(command):
    return run(command, capture_output=True).stdout.decode("utf-8")


def main():
    column = int(get(["tmux", "display", "-pF", "#{copy_cursor_x}"]).strip())
    line = get(["tmux", "display", "-pF", "#{copy_cursor_line}"])

    file_regex = re.compile("([-_/.@a-z:0-9~]+)", re.IGNORECASE)

    total_matches = []
    while True:
        match = file_regex.search(line)

        if match is None:
            e = Exception("Error: No path under cursor!")
            print(e)
            print([match.group(1) for match in total_matches])
            raise e

        if match.start() <= column <= match.end():
            path = match.group(1)
            break

        total_matches.append(match)

        line = line[match.end() :]
        column = column - match.end()

    binary_path = get(["which", "open-path"]).strip()
    try: 
        result = run(["python3", binary_path, path])
    except BaseException as e:
        print(e)
        exit(1)

    if result.returncode != 0:
        print(f"Exited with {result.returncode}")
        print("STDOUT")
        print(result.stdout)
        print("STDERR")
        print(result.stderr)



if __name__ == "__main__":
    main()
