# rd_utils.py
import io
import requests
from urllib.parse import quote
import pandas as pd
import config

session = requests.Session()
session.auth = (config.USER, config.APP_PASSWORD)

# IMPORTANT: define BASE before any function uses it
BASE = f"{config.BASE_URL.rstrip('/')}/{quote(config.USER, safe='')}"


def _enc(parts):
    """Percent-encode path components for safe URLs"""
    return "/".join(quote(p, safe='') for p in parts)


def webdav_download_bytes(rel_path: str) -> bytes:
    url = f"{BASE}/{_enc(rel_path.strip('/').split('/'))}"
    r = session.get(url, stream=True, timeout=60)
    r.raise_for_status()
    return r.content


def read_csv(rel_path: str, **kwargs) -> pd.DataFrame:
    data = webdav_download_bytes(rel_path)
    return pd.read_csv(io.BytesIO(data), **kwargs)


def read_parquet(rel_path: str) -> pd.DataFrame:
    """Read a Parquet file from Research Drive into a DataFrame."""
    data = webdav_download_bytes(rel_path)
    return pd.read_parquet(io.BytesIO(data))


def write_csv(df: pd.DataFrame, rel_path: str, **kwargs):
    """Write a DataFrame as CSV to Research Drive."""
    webdav_mkdirs("/".join(rel_path.split("/")[:-1]))
    data = df.to_csv(index=False, **kwargs).encode("utf-8")
    webdav_upload_bytes(rel_path, data, content_type="text/csv")


def write_parquet(df: pd.DataFrame, rel_path: str):
    """Write a DataFrame as Parquet to Research Drive."""
    webdav_mkdirs("/".join(rel_path.split("/")[:-1]))
    buffer = io.BytesIO()
    df.to_parquet(buffer, index=False)
    buffer.seek(0)
    webdav_upload_bytes(rel_path, buffer.getvalue())


def write_pickle(df: pd.DataFrame, rel_path: str):
    webdav_mkdirs("/".join(rel_path.split("/")[:-1]))
    buffer = io.BytesIO()
    df.to_pickle(buffer)
    buffer.seek(0)
    webdav_upload_bytes(rel_path, buffer.getvalue())

def webdav_mkdirs(rel_path: str):
    """
    Recursively create folders on the Research Drive (like mkdir -p).
    rel_path: relative path inside the Research Drive.
    """
    parts = [p for p in rel_path.strip("/").split("/") if p]
    url = BASE
    for part in parts:
        url = f"{url}/{quote(part, safe='')}"
        r = session.request("MKCOL", url)
        if r.status_code in (201, 405):  # 201 = created, 405 = already exists
            continue
        else:
            r.raise_for_status()


def webdav_upload_bytes(rel_path: str, data: bytes, content_type="application/octet-stream"):
    """
    Upload a file (from bytes) to the Research Drive.
    rel_path: relative path inside the Research Drive.
    """
    url = f"{BASE}/{_enc(rel_path.strip('/').split('/'))}"
    r = session.put(url, data=data, headers={"Content-Type": content_type})
    r.raise_for_status()
