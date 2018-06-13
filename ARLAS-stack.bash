#!/bin/bash -e

##################
# Functions
##################

down () {
	echo "Shutting down containers..."
	docker-compose $docker_compose_file_options down

	echo "Removing containers' network..."
	set +e
	docker network rm arlas
	set -e

	echo "Removing docker bind-mount for WUI configuration..."
	set +e
	docker volume rm arlasstack_wui-configuration
	set -e
}

parse_arguments () {
	# Inspired from https://stackoverflow.com/a/29754866/3037171

	usage="Usage:
	$0 [-e|--elasticsearch false|true] action
	  action: down|up"

	if [[ "$(getopt --test > /dev/null; echo "$?")" != 4 ]]; then
		echo "I’m sorry, `getopt --test` failed in this environment."
		exit 1
	fi

	OPTIONS=e:
	LONGOPTIONS=elasticsearch:

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
			-e|--elasticsearch)
				if [[ "$2" == true ]]; then
					:
				elif [[ "$2" == false ]]; then
					docker_compose_file_options="-f docker-compose.yml"
				else
					>&2 echo "-e|--elasticsearch: Unrecognized value \"$2\", exiting..."
					>&2 echo "$usage"
					exit 5
				fi
				shift 2
				;;
			--)
				shift
				break
				;;
			*)
				>&2 echo "Option parsing problem, exiting..."
				>&2 echo "$usage"
				exit 3
				;;
		esac
	done

	# handle non-option arguments
	if (( $# != 1 )); then
		>&2 echo "Wrong argument count, exiting"
		>&2 echo "$usage"
		exit 4
	fi

	action="$1"
}

up () {
	down

	echo "Creating containers' network..."
	docker network create arlas

	echo "Pulling containers' images"
	# `docker-compose up` does not pull latest version of docker images, hence why the `docker-compose pull`
	docker-compose pull
	
	echo "Starting stack..."
	docker-compose up -d
}


##################
# Operate
##################

parse_arguments $@

if [[ "$action" == "down" ]]; then
	down
elif [[ "$action" == "up" ]]; then
	up
else
	>&2 echo "action: Unrecognized value \"$2\", exiting..."
	>&2 echo "$usage"	
fi
