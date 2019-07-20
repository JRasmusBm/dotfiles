from dataclasses import dataclass

@dataclass
class FileInfo:
    is_dir: bool
    source: str
    target: str
