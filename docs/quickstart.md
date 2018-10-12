This Quick Start will have you run a local instance of the ARLAS Exploration Stack, initialized with [AIS](https://en.wikipedia.org/wiki/Automatic_identification_system) data (ships) from Denmark.

# Prerequisites

- See prerequisites for the ARLAS Exploration Stack [Manager](arlas-exploration-stack-manager.md#prerequisites) & [Initializer](arlas-exploration-stack-initializer.md#prerequisites).
- Have the following ports available on your machine:
  - 80
  - 9200
  - 9300
  - 9999

# Run

- [Download the ARLAS Exploration Stack Manager's script](arlas-exploration-stack-manager.md#download)

- Run the stack:


```bash
./ARLAS-Exploration-stack.bash up
```

# Initialize

- Download the AIS configuration & data sample provided by Gisaïa:

```bash
ARLAS_EXPLORATION_STACK_VERSION=7.0.0

curl -L https://github.com/gisaia/ARLAS-Exploration-stack/archive/v$ARLAS_EXPLORATION_STACK_VERSION.tar.gz \
  | tar -f - --strip-components 2 -x -z ARLAS-Exploration-stack-$ARLAS_EXPLORATION_STACK_VERSION/data_samples/ais-danmarks
```

- Run initialization *(Estimated time: 2mn)*:

```bash
docker run \
  -e elasticsearch_index=ais-danmark \
  -e server_collection_name=ais-danmark \
  -i \
  --mount dst="/initialization",src="$PWD/ais-danmark",type=bind \
  --mount type=volume,src=default_wui-configuration,dst=/wui-configuration \
  --name arlas-exploration-stack-initializer \
  --net arlas \
  --rm \
  -t \
  gisaia/arlas-exploration-stack-initializer
```

# Use

ARLAS should now be up & initialized, you can use it by visiting [localhost](http://localhost) in a web browser.

# Read more

- [Detailed documentation of the ARLAS Exploration Stack Manager](arlas-exploration-stack-manager.md)
- [Detailed documentation of the ARLAS Exploration Stack Initializer](arlas-exploration-stack-initializer.md)
