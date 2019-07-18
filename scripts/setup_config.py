from pathlib import Path


class Config:
    def __init__(self):
        try:
            with open("../files_to_copy.txt") as f:
                raw = f.read()
        except:
            with open("./files_to_copy.txt") as f:
                raw = f.read()

        self._link_pairs = [
            tuple(
                Path(file_name)
                for file_name in file_info.split(",")
            )
            for file_info in raw.split("\n")
            if file_info
        ]

    @property
    def links(self):
        return [link[0] for link in self._link_pairs]

    @property
    def symlinks(self):
        return [link[1] for link in self._link_pairs]

    @property
    def file_mappings(self):
        return {link[0]: link[1] for link in self._link_pairs}


config = Config()

if __name__ == "__main__":
    print(config.file_mappings)
