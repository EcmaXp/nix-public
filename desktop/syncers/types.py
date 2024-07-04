from dataclasses import dataclass
from pathlib import Path
from typing import Callable


@dataclass
class Syncer:
    name: str
    sync: Callable[[], bool]
    config_files: list[Path]
