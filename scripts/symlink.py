from pathlib import Path
from subprocess import run

from backup import backup
from file_writer import read_config


def symlink(backup_folder="~/.backup_dotfiles"):
    backup(backup_folder)
    for the_file in read_config("./files.csv"):
        original_path = the_file.source
        symlink_path = Path.home() / the_file.target
        if not symlink_path.parents[0].is_dir():
            run(["mkdir", "-p", symlink_path.parents[0]])
        if not symlink_path.is_symlink():
            symlink_path.symlink_to(
                original_path, target_is_directory=the_file.is_dir
            )


if __name__ == "__main__":
    symlink()
