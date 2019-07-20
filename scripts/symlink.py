from pathlib import Path

from backup import backup
from file_writer import read_config


def symlink(backup_folder="~/.backup_dotfiles"):
    backup(backup_folder)
    for file in read_config("./files.csv"):
        original_path = file.source
        symlink_path = Path.home() / file.target
        if not symlink_path.is_symlink():
            symlink_path.symlink_to(
                original_path, target_is_directory=exec(file.is_dir)
            )


if __name__ == "__main__":
    symlink()
