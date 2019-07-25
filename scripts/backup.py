from pathlib import Path
from shutil import move
from file_writer import write_config, read_config


def backup(dir_path, overwrite=False):
    backup_dir = Path(dir_path).expanduser().resolve()
    backup_log = backup_dir / "backup_log.csv"
    log_files = read_config(backup_log) if backup_log.exists() else []
    for the_file in read_config("./files.csv"):
        original_path = Path.home() / the_file.target
        backup_path = backup_dir / the_file.target
        if not (backup_path).exists():
            dir_part = Path(*backup_path.parts[:-1])
            dir_part.mkdir(parents=True, exist_ok=True)
            move(original_path, backup_path)
            log_files.append(the_file)
    write_config(backup_log, log_files)


if __name__ == "__main__":
    backup("~/.backup_dotfiles")
