#!/bin/bash -e

export data_file=/aisdk_20180102_head100000.csv
export elasticsearch_index=ais-danmark
export elasticsearch_mapping=/mapping.json
export logstash_configuration=/csv2es.logstash.conf

export server_collection=/server-collection.json
cat > "$server_collection" <<EOF
{  
  "index_name": "$INDEXNAME",
  "type_name": "logs",
  "id_path": "vessel.mmsi",
  "geometry_path": "course.segment.geometry.geometry",
  "centroid_path": "position.location",
  "timestamp_path": "position.timestamp"
}
EOF

export server_collection_name=ais-danmark

export WUI_configuration=/WUI-config.json
curl -s https://raw.githubusercontent.com/gisaia/ARLAS-wui/feat/ais-data/src/config.json | jq '.arlas.server.url="http://localhost:9999/arlas"' > "$WUI_configuration"

export WUI_map_configuration=/WUI-map-config.json
curl -o "$WUI_map_configuration" -s https://raw.githubusercontent.com/gisaia/ARLAS-wui/feat/ais-data/src/config.map.json

/base.bash
