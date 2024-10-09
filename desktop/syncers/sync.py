import sys
from datetime import datetime
from pathlib import Path

import click
from watchdog.events import PatternMatchingEventHandler
from watchdog.observers import Observer

from .config import CONFIG_ALL_FOLDERS
from .programs.karabiner import karabiner_syncer
from .programs.launchpad import launchpad_syncer
from .types import Syncer
from .utils import now

SYNCERS = {
    syncer.name: syncer
    for syncer in [
        karabiner_syncer,
        launchpad_syncer,
    ]
}


def sync(
    syncers: dict[str, Syncer],
    files: list[Path] | None = None,
):
    if files is not None:
        files = [file.resolve() for file in files]

    for name, syncer in syncers.items():
        modified = False
        if files is not None:
            for file in files:
                if file in syncer.resolve_config_files():
                    modified |= True
                    modified_at = datetime.fromtimestamp(file.stat().st_mtime)
                    print(f"[{now(modified_at)}] {file.name} modified")

        if files is None or modified:
            synced = syncer.sync()
            if synced:
                print(f"[{now()}] {syncer.name} synced")


def sync_forever(syncers: dict[str, Syncer]):
    sync(syncers=syncers)
    print(f"[{now()}] watching for changes...")

    class SyncHandler(PatternMatchingEventHandler):
        def on_modified(self, event):
            path = Path(event.src_path).resolve()
            sync(syncers=syncers, files=[path])

    event_handler = SyncHandler(["*.yaml"])

    observer = Observer()
    for folder in {
        file.resolve().parent
        for folder in CONFIG_ALL_FOLDERS
        for file in folder.glob("*.yaml")
    } | set(CONFIG_ALL_FOLDERS):
        observer.schedule(event_handler, folder)

    observer.start()

    try:
        while observer.is_alive():
            observer.join(1)
    except KeyboardInterrupt:
        pass
    finally:
        observer.stop()
        observer.join()


@click.command()
@click.argument("programs", nargs=-1)
@click.option("--forever", is_flag=True)
def main(
    programs: tuple[str, ...] = (),
    forever: bool = False,
):
    if programs:
        try:
            syncers = {program: SYNCERS[program] for program in programs}
        except KeyError as e:
            sys.exit(f"unknown program: {e}")
    else:
        syncers = SYNCERS

    if forever:
        sync_forever(syncers=syncers)
    else:
        sync(syncers=syncers)


if __name__ == "__main__":
    main()
