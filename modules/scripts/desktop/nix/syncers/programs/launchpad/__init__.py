from ...config import LAUNCHPAD_USER_CONFIG_PATH
from ...types import Syncer
from .sync import sync_launchpad

launchpad_syncer = Syncer(
    name="launchpad",
    sync=sync_launchpad,
    config_files=[
        LAUNCHPAD_USER_CONFIG_PATH,
    ],
)
