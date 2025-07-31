#!/usr/bin/env python3
from __future__ import annotations

import subprocess
import unicodedata

from sqlmodel import Session, select

from ...config import load_launchpad_config
from . import db
from .types import Folder, Launchpad, Root, split_pages

NBSP = "\u00a0"


def sync_launchpad() -> bool:
    # Load configuration
    load_launchpad_config.cache_clear()
    config: list[dict[str, list[str]] | str] = load_launchpad_config()
    pages = split_pages(config)

    engine = db.create_engine()
    with Session(engine) as session:
        launchpad = Launchpad(session)
        root = Root(launchpad)

        # Load apps from a database
        db_apps = {
            f"{unicodedata.normalize('NFC', app.title).replace(NBSP, ' ')} ({app.bundleid})": app
            for app in session.exec(select(db.App)).all()
        }

        # Check all apps are used and available
        remote_apps = frozenset(db_apps.keys())
        local_apps = frozenset(
            {
                app
                for page in pages
                for obj in page
                if isinstance(obj, dict)
                for folder_page in obj.values()
                for app in folder_page
            }
            | {app for page in pages for app in page if isinstance(app, str)}
        )

        if local_apps != remote_apps:
            if remote_apps - local_apps:
                print("Missing apps:")
                for app in remote_apps - local_apps:
                    print("-", app)
                print()

            if local_apps - remote_apps:
                print("Unused apps:")
                for app in local_apps - remote_apps:
                    print("-", app)

            return False

        # Disable update trigger
        db.set_ignore_items_update_triggers(True, session=session, nested=True)

        # Update existing pages
        updated = False
        offset = 1  # Skip the first page
        updated |= root.resize_pages(len(pages) + offset)
        for page, remote_page in zip(pages, list(root)[offset:], strict=False):
            for i, obj in enumerate(page):
                if isinstance(obj, dict):
                    folder_name, folder_page = obj.popitem()
                    assert not obj
                    folder, created = remote_page.create_folder(folder_name)
                    updated |= created
                    updated |= folder.update_pages(
                        split_pages(
                            [db_apps[app_bundleid] for app_bundleid in folder_page]
                        )
                    )
                    page[i] = folder.obj
                else:
                    page[i] = db_apps[obj]

            updated |= remote_page.update_page(page)

        # Delete unused folders/pages
        for page in list(root)[offset:]:
            for child in page:
                if isinstance(child, Folder) and not list(child.items()):
                    updated |= True
                    child.delete()

            if not page:
                updated |= True
                page.delete()

        # Commit changes
        if updated:
            subprocess.run(["killall", "Dock"])
            session.commit()
        else:
            session.rollback()

        # Enable update trigger
        db.set_ignore_items_update_triggers(False, session=session, nested=False)

    return updated
