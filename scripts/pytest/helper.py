from arlas.cli.service import Service

from variables import USER_ADMIN


def get_groups_and_roles(oid: str) -> list[list[str]]:
    groups = list(map(lambda arr: arr[0], Service.list_organisation_groups(USER_ADMIN, oid)))
    roles = list(map(lambda arr: arr[0], Service.list_organisation_roles(USER_ADMIN, oid)))
    return groups + roles

def see_collection(user: str, collection: str):
    Service.list_collections()