from datetime import datetime


def now(dt: datetime = None):
    if not dt:
        dt = datetime.now()

    return dt.isoformat(" ", "seconds")
