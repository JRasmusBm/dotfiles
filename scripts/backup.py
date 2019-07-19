from setup_config import config, Config
from pathlib import Path


def backup(dir_path, overwrite=False):
    backup_dir = Path(dir_path).expanduser().resolve()
    log = []
    for path in config.symlinks:
        if not (backup_dir / path).exists():
            original_path = Path.home() / path
            backup_path = backup_dir / path
            dir_part = Path(*backup_path.parts[:-1])
            dir_part.mkdir(parents=True, exist_ok=True)
            original_path.rename(backup_path)
            log.append(f"{ backup_path },{ original_path }")
    log_file = backup_dir / ".backup.log"
    if not log_file.exists():
        print(log_file)
        log_file.touch()
    with open(log_file, "a") as f:
        f.write("\n".join(log))


def restore(dir_path):
    backup_dir = Path(dir_path).expanduser().resolve()
    log_file = backup_dir / ".backup.log"
    backup_config = Config(log_file)
    log = []
    for path in backup_config.file_mappings:
        backup_path = backup_dir / path
        if backup_path.exists():
            original_path = Path.home() / backup_config.file_mappings[path]
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
                    log.append(f"{ backup_path },{ original_path }")
                    continue
            backup_path.rename(original_path)
    with open(log_file, "w") as f:
        f.write("\n".join(log))


def symlink():
    backup("~/.backup_dotfiles")
    for symlink, link in zip(config.symlinks, config.links):
        symlink_path = Path.home() / symlink
        print(f"symlink_path: {symlink_path}")
        print(f"link: {link}")
        if not symlink_path.is_symlink():
            symlink_path.symlink_to(link.resolve())


if __name__ == "__main__":
    # symlink()
    # backup("~/.backup_dotfiles")
    restore("~/.backup_dotfiles")
