import os
from arlas.cli.service import Service
import requests
from arlas.cli.settings import Configuration

from variables import USER_ADMIN


def get_groups_and_roles(oid: str) -> dict[str, str]:
    groups = Service.list_organisation_groups(USER_ADMIN, oid) + Service.list_organisation_roles(USER_ADMIN, oid)
    return dict(map(lambda arr: (arr[1], arr[0]), groups))


def get_groups_and_roles_ids(oid: str) -> list[str]:
    groups = Service.list_organisation_groups(USER_ADMIN, oid) + Service.list_organisation_roles(USER_ADMIN, oid)
    return list(map(lambda arr: arr[0], groups))


def create_user(run_as, user_email):
    user = Service.create_user(run_as, user_email)
    os.system("./scripts/pytest/reset_pwd.sh " + user.get("email") + " " + user.get("id"))
    return user.get("email"), user.get("id")


def see_collection(user: str, collection: str):
    collections = list(map(lambda arr: arr[0], Service.list_collections(user)))
    return collection in collections


def see_user(user: str, oid: str, target: str):
    users = list(map(lambda arr: arr[1], Service.list_organisation_users(user, oid)))
    return target in users


def see_collection_iam(user: str, oid: str, collection: str):
    print(Service.list_organisation_collections(user, oid))
    collections = list(map(lambda arr: arr[0], Service.list_organisation_collections(user, oid)))
    return collection in collections


def see_organisation(user: str, org: str):
    orgs = list(map(lambda arr: arr[0], Service.list_organisations(user)))
    return org in orgs


def create_collection(user: str, org: str, collection: str, index: str, is_public: bool):
    Service.create_collection(
        arlas=user,
        collection=collection,
        model_resource=None,
        index=index,
        display_name=collection,
        owner=org,
        orgs=[org],
        is_public=is_public,
        id_path="track.id",
        centroid_path="track.location",
        geometry_path="track.trail",
        date_path="track.timestamps.center")


def anonymous_iam_call(action, post=None, delete=False):
    url = Configuration.settings.arlas.get(USER_ADMIN).authorization.token_url.location.removesuffix("session") + action
    headers = Configuration.settings.arlas.get(USER_ADMIN).authorization.token_url.headers
    return call(url, post, delete, headers)


def api_key_call(action, key, secret, post=None, delete=False):
    url = Configuration.settings.arlas.get(USER_ADMIN).server.location + action
    headers = Configuration.settings.arlas.get(USER_ADMIN).server.headers.copy()
    headers["arlas-api-key-id"] = key
    headers["arlas-api-key-secret"] = secret
    return call(url, post, delete, headers)


def call(url, post=None, delete=False, headers={}):
    if post:
        return requests.post(url, data=post, headers=headers, verify=False)
    elif delete:
        return requests.delete(url, headers=headers, verify=False)
    else:
        return requests.get(url, headers=headers, verify=False)
