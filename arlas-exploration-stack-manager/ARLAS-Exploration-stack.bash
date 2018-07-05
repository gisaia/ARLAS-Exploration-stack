#!/bin/bash -e

##################
# Variables
##################

## Usage

global_options_string="Global options:
  -h, --help"


global_usage="Usage:
  ./$(basename "$0") [global-options] <command> [command-options]
  
Commands:
  down
  up

$global_options_string"

declare -A usage

usage[down]="Usage:
  ./$(basename "$0") [global-options] down [options]

Options:
  -e, --no-elasticsearch  Do not try to delete the (potential) elasticsearch container
  -n, --no-network        Do not try to delete the docker network

$global_options_string"


usage[up]="Usage:
  ./$(basename "$0") [global-options] up [options]

Options:
  -e, --no-elasticsearch  Do not bring up an elasticsearch container
  -n, --no-network        Do not create the docker network
  -p, --no-pull           If docker images are present locally, do not try to pull new version

$global_options_string"


##################
# Functions
##################

down () {
	log "Shutting down containers..."
	docker-compose $docker_compose_file_options down

  network=arlas
	if ! [[ -v no_network ]] && docker network inspect "$network" &>>/dev/null; then
		log "Removing containers' network..."
		docker network rm "$network"
	fi

  configuration_volume=default_wui-configuration
  if docker inspect "$configuration_volume" &>>/dev/null; then
    log "Removing docker volume for WUI configuration..."
    docker volume rm "$configuration_volume"
  fi
}

log () {

# Special case of the 1st log line: we do not want to have a blank line between the command prompt & the 1st log line.
  if ! [[ -v first_log_done ]]; then
    first_log_done=true
  else
    echo
  fi


  echo "> $1"
}

log_error () {
  >&2 echo "[ERROR] $1" 
}

parse_arguments () {
  # Inspired from https://stackoverflow.com/a/29754866/3037171

  if [[ "$(getopt --test > /dev/null; echo "$?")" != 4 ]]; then
    log_error "I’m sorry, `getopt --test` failed in this environment."
    exit 1
  fi

  OPTIONS=hepn
  LONGOPTIONS=help,no-elasticsearch,no-pull,no-network

  # -temporarily store output to be able to check for errors
  # -e.g. use “--options” parameter by name to activate quoting/enhanced mode
  # -pass arguments only via   -- "$@"   to separate them correctly
  PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTIONS --name "$0" -- "$@")
  if (( $? != 0 )); then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
  fi
  # read getopt’s output this way to handle the quoting right:
  eval set -- "$PARSED"

  # now enjoy the options in order and nicely split until we see --
  while true; do
    case "$1" in
      -h|--help)
        help=true
        shift
        ;;
      -e|--no-elasticsearch)
        docker_compose_file_options="-f docker-compose.yml"
        shift
        ;;
      -p|--no-pull)
        no_pull=true
        shift
        ;;
      -n|--no-network)
        no_network=true
        shift
        ;;
      --)
        shift
        break
        ;;
      *)
        log_error "Option parsing problem, exiting..."
        >&2 echo "$global_usage"
        exit 3
        ;;
    esac
  done

  # handle non-option arguments
  if (( $# == 0 )) && [[ -v help ]]; then
    :
  elif (( $# == 1 )); then
    command="$1"
  else
    log_error
    log_error "Wrong argument count, exiting"
    >&2 echo "$global_usage"
    exit 4
  fi
}

up () {
  down

  if ! [[ "$no_network" == true ]]; then
    log "Creating containers' network..."
    docker network create arlas
  fi

  if ! [[ "$no_pull" == true ]]; then
    log "Pulling containers' images"
    # `docker-compose up` does not pull latest version of docker images, hence why the `docker-compose pull`
    docker-compose $docker_compose_file_options pull
  fi
  
  log "Starting stack..."
  docker-compose $docker_compose_file_options up -d
}


##################
# Operate
##################

parse_arguments $@

if [[ -v help ]]; then
  if [[ -v command ]]; then
    echo "${usage[$command]}"
  else
    echo "$global_usage"
  fi
  exit 0
fi

# Merge configuration
cat .env_user >> .env

if [[ "$command" == "down" ]]; then
  down
elif [[ "$command" == "up" ]]; then
  up
else
  log_error "Unrecognized command \"$2\", exiting..."
  >&2 echo "$global_usage"
fi