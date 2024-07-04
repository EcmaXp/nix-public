from .sync import sync_launchpad
from ...types import Syncer
from ...config import LAUNCHPAD_CONFIG_PATH

launchpad_syncer = Syncer(
    name="launchpad",
    sync=sync_launchpad,
    config_files=[
        LAUNCHPAD_CONFIG_PATH,
    ],
)
