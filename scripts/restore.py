from pathlib import Path
from shutil import move

from file_writer import read_config, write_config


def restore(dir_path):
    backup_dir = Path(dir_path).expanduser().resolve()
    log_file = backup_dir / "backup_log.csv"
    log_files = []

    for file in read_config("./files.csv"):
        original_path = Path.home() / file.target
        backup_path = backup_dir / file.target
        print(backup_path)
        if backup_path.exists():
            if not original_path.is_symlink() and original_path.exists():
                accept = False
                choice = input(
                    f"""


Trying to restore from {backup_path}...
... but {original_path} is not a symlink.

{original_path} will be overwritten if you choose to continue?

Overwrite [Y/n]?
            """
                )
                if choice not in ["Y", "y"]:
                    log_files.append(file)
                    continue
            move(backup_path, original_path)
    write_config(log_file, log_files)


if __name__ == "__main__":
    restore("~/.backup_dotfiles")
