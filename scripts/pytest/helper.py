import os
from arlas.cli.service import Service

from variables import USER_ADMIN


def get_groups_and_roles(oid: str) -> dict[str, str]:
    groups = Service.list_organisation_groups(USER_ADMIN, oid) + Service.list_organisation_roles(USER_ADMIN, oid)
    return dict(map(lambda arr: (arr[1], arr[0]), groups))


def create_user(run_as, user_email):
    user = Service.create_user(run_as, user_email)
    os.system("./scripts/pytest/reset_pwd.sh " + user.get("email") + " " + user.get("id"))
    return user.get("email"), user.get("id")


def see_collection(user: str, collection: str):
    collections = list(map(lambda arr: arr[0], Service.list_collections(user)))
    return collection in collections


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
