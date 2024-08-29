import re
import sys

from ruamel.yaml import YAML
from ruamel.yaml.comments import CommentedMap, CommentedSeq
from ruamel.yaml.tokens import CommentToken
from pathlib import Path
files = ["dc/ref-dc-arlas-server.yaml"]
pattern = re.compile(r'\$\{(.+)\}')


def escape(string: str) -> str:
    return string  #string.replace("_", "\\_").replace("*", "\\*")


def truncate(string: str) -> str:
    if len(string) > 50:
        return string[:50] + " ..."
    return string


def __get_env_setting__(env_variables: dict[str:list[tuple[str, str]]], variable: str):
    env_settings = []
    for value, envf in env_variables.get(variable, []):
        if not value:
            value = "empty value"
        else:
            value = "`" + value + "`"
        env_settings.append("{} in `{}`".format(value, envf))
    return "<br>".join(env_settings)


def __extract_env_pattern__(v, env_variables) -> tuple[str, str, str]:
    m = pattern.search(v)
    if m:
        if m.group(1).find(":-") > 0:
            variable, default = m.group(1).split(":-")
        else:
            variable, default = (m.group(1), "")
        env_settings = __get_env_setting__(env_variables, variable)
        return (variable, default, env_settings)
    else:
        return (truncate(v), "", "")


def generate(yaml_files: list[str], env_files: list[str]):
    env_variables: dict[str:list[tuple[str, str]]] = {}
    for f in env_files:
        with open(f, 'r') as file:
            while line := file.readline():
                if not line.lstrip().startswith("#"):
                    if line.find("=") > 0:
                        k, v = line.split("=", 1)
                        k = k.strip()
                        v = truncate(v.strip())
                        env_variables[k] = env_variables.get(k, [])
                        env_variables[k].append((v, f))

    print("## Services:")
    for f in yaml_files:
        with open(f, 'r') as file:
            content = file.read().rstrip()
            yaml = YAML(typ='rt')
            doc = yaml.load(content)
            services = doc.get("services", [])
            for service in services:
                service: CommentedMap = service
                print("- [{}](#service-{})".format(service, service))

    for f in yaml_files:
        with open(f, 'r') as file:
            print("## File {}".format(f))
            content = file.read().rstrip()
            yaml = YAML(typ='rt')
            doc = yaml.load(content)
            services = doc.get("services", [])
            for service in services:
                service: CommentedMap = service
                print("### Service {}".format(service))
                cs = services.get(service).ca.comment
                if cs and len(cs) > 0:
                    c: CommentToken = cs[0]
                    print("Description: {}".format(c.value.lstrip('#').lstrip(' ')))
                image = services.get(service).get("image")
                if image:
                    image, default, env_settings = __extract_env_pattern__(image, env_variables)
                    if env_settings:
                        print("Image: `{}` with {}".format(image, env_settings))
                    else:
                        print("Image: `{}`".format(image))

                envs: CommentedSeq = services.get(service).get("environment", [])
                print("")
                if len(envs) > 0:
                    print("| Container variable | Value or environment variable | Default | Description | Env file setting |")
                    print("| --- | --- | --- | --- | --- |")
                index: int = -1
                for env in envs:
                    index = index + 1
                    k, v = env.split("=", 1)
                    env_settings = ""
                    variable, default, env_settings = __extract_env_pattern__(v, env_variables)
                    description = ""
                    if envs.ca.items.get(index):
                        cs: list[CommentToken] = envs.ca.items.get(index)
                        if len(cs) > 0:
                            c = cs[0]
                            if c.column > 0:
                                description = description + " " + c.value.lstrip('#').lstrip(' ').rstrip()
                    variable = truncate(variable)
                    print("| `{}` | `{}` | `{}` | {} | {} |".format(escape(k), escape(variable), escape(default), escape(description), escape(env_settings)))
                volumes = services.get(service).get("volumes", None)
                if volumes:
                    print()
                    print("List of volumes:")
                    for volume in volumes:
                        print("- " + volume)

yaml_files: list[str] = []
env_files: list[str] = []
for f in sys.argv[1:]:
    if Path(f).suffix == ".env":
        env_files.append(f)
    if Path(f).suffix == ".yaml":
        yaml_files.append(f)

generate(yaml_files, env_files)
