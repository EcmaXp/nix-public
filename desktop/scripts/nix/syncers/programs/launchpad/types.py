from __future__ import annotations

from typing import TypeVar

from sqlalchemy import func
from sqlmodel import Session, select

from . import db

T = TypeVar("T")


class Launchpad:
    def __init__(self, session: Session):
        self.session = session
        self.dbinfos = {
            dbinfo.key: dbinfo.value for dbinfo in session.exec(select(db.DBInfo)).all()
        }
        self.last_obj_id = session.exec(select(func.max(db.Item.rowid))).one()

    def incr_obj_id(self):
        self.last_obj_id += 1
        return self.last_obj_id


class Node:
    def __init__(
        self,
        launchpad: Launchpad,
        obj: db.Group | db.App | db.DownloadingApp,
    ):
        self.launchpad = launchpad
        self.obj = obj
        self.item: db.Item = obj.item

    @property
    def title(self) -> str | None:
        return self.obj.title

    @property
    def ordering(self) -> int:
        return self.item.ordering

    def __repr__(self):
        return f"<{self.__class__.__name__}: {self.title!r}>"


class Group(Node):
    def create_group(
        self,
        node_type: db.ItemType,
        *,
        flags: int = 0,
        title: str = None,
    ) -> db.Group:
        obj_id = self.launchpad.incr_obj_id()
        group = db.Group(
            title=title,
            item_id=obj_id,
            item=db.Item(
                rowid=obj_id,
                type=node_type,
                parent_id=self.item.rowid,
                flags=flags,
            ),
        )
        self.launchpad.session.add(group)
        self.launchpad.session.add(group.item)
        return group


class HasPages(Group):
    def __init__(self, launchpad: Launchpad, obj: db.Group):
        super().__init__(launchpad, obj)

    def __iter__(self):
        for child in self.launchpad.session.exec(
            select(db.Item)
            .where(db.Item.parent_id == self.item.rowid)
            .order_by(db.Item.ordering)
            .join(db.Group, isouter=True)
        ).all():
            yield Page(self.launchpad, child.obj)

    def __len__(self):
        return self.launchpad.session.exec(
            select(func.count(db.Item.rowid)).where(
                db.Item.parent_id == self.item.rowid
            )
        ).one()

    def __bool__(self):
        return len(self) > 0

    def items(self):
        for page in self:
            yield from page

    def create_page(self) -> db.Group:
        assert self.item.type == db.ItemType.Folder
        return self.create_group(db.ItemType.Page)

    def resize_pages(self, size: int) -> bool:
        updated = False
        length = len(self)
        if length < size:
            for _ in range(size - length):
                updated |= True
                self.create_page()

        return updated

    def shink_pages(self, size: int) -> bool:
        updated = False
        length = len(self)
        if length > size:
            for page in list(self)[:size:-1]:
                updated |= True
                page.delete()

        return updated

    def update_pages(
        self, local_pages: list[db.Group | db.App | db.DownloadingApp]
    ) -> bool:
        updated = False
        updated |= self.resize_pages(len(local_pages))
        for page, local_page in zip(self, local_pages):
            updated |= page.update_page(local_page)

        return updated


class Page(Group):
    def __iter__(self):
        for child in self.launchpad.session.exec(
            select(db.Item)
            .where(
                db.Item.parent_id == self.item.rowid,
            )
            .order_by(db.Item.ordering)
            .join(db.Group, isouter=True)
            .join(db.App, isouter=True)
            .join(db.DownloadingApp, isouter=True)
        ).all():
            match child.type:
                case db.ItemType.Folder:
                    yield Folder(self.launchpad, child.obj)
                case db.ItemType.App:
                    yield App(self.launchpad, child.obj)
                case db.ItemType.DownloadingApp:
                    yield App(self.launchpad, child.obj)
                case _:
                    raise ValueError(f"Unknown item type: {child.type!r}")

    def __bool__(self):
        return bool(list(iter(self)))

    def create_folder(self, title: str) -> tuple[Folder, bool]:
        group = self.launchpad.session.exec(
            select(db.Group).where(db.Group.title == title)
        ).first()
        created = False
        if group is None:
            group = self.create_group(db.ItemType.Folder, title=title)
            created = True
        else:
            created |= group.item.parent_id != self.item.rowid
            group.item.parent_id = self.item.rowid
            self.launchpad.session.add(group.item)

        return Folder(self.launchpad, group), created

    def update_page(
        self, local_page: list[db.Group | db.App | db.DownloadingApp]
    ) -> bool:
        session = self.launchpad.session
        parent_id = self.item.rowid
        updated = False
        for i, obj in enumerate(local_page):
            item = obj.item
            updated |= item.parent_id != parent_id
            updated |= item.ordering != i
            item.parent_id = parent_id
            item.ordering = i
            session.add(item)

        return updated

    def delete(self):
        if self:
            raise ValueError("Cannot delete a non-empty page")

        self.launchpad.session.delete(self.obj)
        self.launchpad.session.delete(self.item)


class Root(HasPages, Group):
    def __init__(self, launchpad: Launchpad):
        super().__init__(launchpad, self.get_root(launchpad))

    @staticmethod
    def get_root(launchpad: Launchpad):
        return (
            launchpad.session.exec(
                select(db.Item)
                .where(db.Item.rowid == int(launchpad.dbinfos["launchpad_root"]))
                .join(db.Group)
            )
            .one()
            .group
        )


class Folder(HasPages, Group):
    def delete(self):
        for page in self:
            page.delete()

        if self:
            raise ValueError("Cannot delete a non-empty folder")

        self.launchpad.session.delete(self.obj)
        self.launchpad.session.delete(self.item)


class App(Node):
    pass


def split_pages(seq: list[T]) -> list[list[T]]:
    pages = []
    size = 35

    while seq:
        pages.append(seq[:size])
        seq = seq[size:]

    return pages
