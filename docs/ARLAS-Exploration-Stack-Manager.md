The ARLAS Exploration Stack Manager allows to manage a local instance of the ARLAS Exploration Stack in an easy way: launch it, shut it down, ...

It comes under the form of a script: [ARLAS-Exploration-stack.bash](https://github.com/gisaia/ARLAS-Exploration-stack/tree/master/ARLAS-Exploration-stack.bash).

The local ARLAS Eploration Stack it controls consists in several [docker](https://docker.com) containers tied together using [Docker Compose](https://docs.docker.com/compose).

repository: https://github.com/gisaia/ARLAS-Exploration-stack/tree/master/arlas-exploration-stack-manager

# Prerequisites

- [Docker CE](https://docs.docker.com/install/) (Community Edition) >=  18.02.0

# Build

@ [the repository's root](https://github.com/gisaia/ARLAS-Exploration-stack/tree/master):

```bash
cd arlas-exploration-stack-manager; docker build -t gisaia/arlas-exploration-stack-manager .; cd -
```

# Usage

@ [the repository's root](https://github.com/gisaia/ARLAS-Exploration-stack/tree/master):

```bash
# up
./ARLAS-Exploration-stack.bash up
# By default, the WUI will be exposed on http://localhost


# down
./ARLAS-Exploration-stack.bash down

# List all available commands/options
./ARLAS-Exploration-stack.bash -h

# You can use the `-h` option on any command to get more info on it
```

## Configuration

### Docker Compose `.env` file

The manager uses [the Docker Compose's `.env` file mechanism](https://docs.docker.com/compose/env-file/) to configure the stack's docker compose. You can find available environment variables in [arlas-exploration-stack-manager/.env](https://github.com/gisaia/ARLAS-Exploration-stack/blob/master/arlas-exploration-stack-manager/.env), with their default values. You can override them by creating & filling a `.env` file at the root of the project.

```bash
touch .env
```

### Docker Compose `env_file` mechanism

We use [the Docker Compose's `env_file` mechanism](https://docs.docker.com/compose/compose-file/#env_file) to populate environment variables inside containers. Each container has its own distinct `env_file` s. Default values are found under [arlas-exploration-stack-manager/environment](https://github.com/gisaia/ARLAS-Exploration-stack/tree/master/arlas-exploration-stack-manager/environment). You can set new values, or override the defaults, by creating & the following files:

```bash
mkdir -p environment
touch environment/arlas-exploration-stack-server \
      environment/arlas-exploration-stack-wui \
      environment/arlas-exploration-stack-elasticsearch
```
