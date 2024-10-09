from dataclasses import dataclass
from pathlib import Path
from typing import Callable


@dataclass
class Syncer:
    name: str
    sync: Callable[[], bool]
    config_files: list[Path]

    def resolve_config_files(self) -> list[Path]:
        return [file.resolve() for file in self.config_files]
