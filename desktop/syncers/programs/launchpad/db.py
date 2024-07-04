from __future__ import annotations

import enum
import subprocess
from pathlib import Path
from uuid import uuid4

import sqlmodel
from sqlalchemy import Column, Integer, String, Float, ForeignKey, LargeBinary
from sqlalchemy.orm import declarative_base, relationship, Mapped
from sqlalchemy_utils import ChoiceType
from sqlmodel import Session, select

Base = declarative_base()


def get_darwin_user_dir() -> Path:
    return Path(
        subprocess.check_output(["getconf", "DARWIN_USER_DIR"], text=True).strip()
    ).resolve()


def get_launchpad_db() -> Path:
    return get_darwin_user_dir() / "com.apple.dock.launchpad/db/db"


def create_engine():
    return sqlmodel.create_engine(f"sqlite:///{get_launchpad_db().as_posix()}")


class DBInfo(Base):
    __tablename__ = "dbinfo"

    key: str = Column(String, primary_key=True)
    value: str | None = Column(String, nullable=True)


class ItemType(enum.IntEnum):
    # groups
    Root = 1
    Folder = 2
    Page = 3
    # apps
    App = 4
    # downloading apps
    DownloadingApp = 5
    # widgets
    Widget = 6

    def __str__(self):
        return self.name


class Item(Base):
    __tablename__ = "items"

    rowid: int = Column(Integer, primary_key=True)
    parent_id: int = Column(Integer, ForeignKey("items.rowid"))
    uuid: str | None = Column(String, nullable=True, default=lambda: str(uuid4()))
    flags: int | None = Column(Integer, nullable=True, default=0)
    type: ItemType = Column(ChoiceType(ItemType, impl=Integer()), nullable=False)
    ordering: int | None = Column(Integer, nullable=True)

    parent: Mapped[Item] = relationship(
        "Item",
        uselist=False,
        back_populates="children",
        remote_side=[rowid],  # noqa
    )
    children: Mapped[list[Item]] = relationship(
        "Item",
        back_populates="parent",
        remote_side=[parent_id],  # noqa
    )

    group: Mapped[Group] = relationship(
        "Group",
        uselist=False,
        back_populates="item",
    )
    app: Mapped[App] = relationship(
        "App",
        uselist=False,
        back_populates="item",
    )
    downloading_app: Mapped[DownloadingApp] = relationship(
        "DownloadingApp",
        uselist=False,
        back_populates="item",
    )

    @property
    def obj(self) -> Group | App | DownloadingApp | None:
        match self.type:
            case ItemType.Root:
                return self.group
            case ItemType.Folder:
                return self.group
            case ItemType.Page:
                return self.group
            case ItemType.App:
                return self.app
            case ItemType.DownloadingApp:
                return self.downloading_app
            case ItemType.Widget:
                return self.group
            case _:
                raise ValueError(f"Unknown item type: {self.type!r}")

    def __repr__(self):
        return f"<Item(rowid={self.rowid!r}, parent_id={self.parent_id!r}, type={self.type!r}, flags={self.flags!r})>"


class HasItem:
    item: Mapped[Item]

    def delete(self, session):
        session.delete(self.item)
        session.delete(self)


class Category(Base):
    __tablename__ = "categories"

    rowid: int = Column(Integer, primary_key=True)
    uti: str | None = Column(String, nullable=True)

    apps: Mapped[list[App]] = relationship(
        "App",
        back_populates="category",
    )
    downloading_apps: Mapped[list[DownloadingApp]] = relationship(
        "DownloadingApp",
        back_populates="category",
    )
    groups: Mapped[list[Group]] = relationship(
        "Group",
        back_populates="category",
    )


class Group(HasItem, Base):
    __tablename__ = "groups"

    item_id: int = Column(Integer, ForeignKey("items.rowid"), primary_key=True)
    category_id: int | None = Column(
        Integer, ForeignKey("categories.rowid"), nullable=True
    )
    title: str | None = Column(String, nullable=True)

    item: Mapped[Item] = relationship(
        "Item",
        back_populates="group",
    )
    category: Mapped[Category] = relationship(
        "Category",
        back_populates="groups",
    )

    def __repr__(self):
        return f"<Group(title={self.title!r}, item={self.item!r})>"


class App(HasItem, Base):
    __tablename__ = "apps"

    item_id: int = Column(Integer, ForeignKey("items.rowid"), primary_key=True)
    title: str | None = Column(String, nullable=True)
    bundleid: str | None = Column(String, nullable=True)
    storeid: str | None = Column(String, nullable=True)
    category_id: int | None = Column(
        Integer, ForeignKey("categories.rowid"), nullable=True
    )
    moddate: float | None = Column(Float, nullable=True)
    bookmark: bytes | None = Column(LargeBinary, nullable=True)

    item: Mapped[Item] = relationship(
        "Item",
        back_populates="app",
    )
    category: Mapped[Category] = relationship(
        "Category",
        back_populates="apps",
    )

    def __repr__(self):
        return f"<App(title={self.title!r}, item={self.item!r})>"


class AppSource(Base):
    __tablename__ = "app_sources"

    rowid: int = Column(Integer, primary_key=True)
    uuid: str | None = Column(String, nullable=True)
    flags: int | None = Column(Integer, nullable=True)
    bookmark: bytes | None = Column(LargeBinary, nullable=True)
    last_fsevent_id: int | None = Column(Integer, nullable=True)
    fsevent_uuid: str | None = Column(String, nullable=True)


class DownloadingApp(HasItem, Base):
    __tablename__ = "downloading_apps"

    item_id: int = Column(Integer, ForeignKey("items.rowid"), primary_key=True)
    title: str | None = Column(String, nullable=True)
    bundleid: str | None = Column(String, nullable=True)
    storeid: str | None = Column(String, nullable=True)
    category_id: int | None = Column(
        Integer, ForeignKey("categories.rowid"), nullable=True
    )
    install_path: str | None = Column(String, nullable=True)

    item: Mapped[Item] = relationship(
        "Item",
        back_populates="downloading_app",
    )
    category: Mapped[Category] = relationship(
        "Category",
        back_populates="downloading_apps",
    )

    def __repr__(self):
        return f"<DownloadingApp(title={self.title!r})>"


def set_ignore_items_update_triggers(value: bool, *, session: Session, nested: bool):
    session.begin(nested=nested)

    dbinfo: DBInfo = session.exec(
        select(DBInfo).where(DBInfo.key == "ignore_items_update_triggers")
    ).one()
    dbinfo.value = str(int(value))

    session.add(dbinfo)
    session.commit()
