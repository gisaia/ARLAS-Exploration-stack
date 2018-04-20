#!/bin/bash -e

export data_file=/aisdk_20180102_head100000.csv
export elasticsearch_index=ais-danmark
export elasticsearch_mapping=/mapping.json
export logstash_configuration=/csv2es.logstash.conf

export server_collection=/server-collection.json
cat > "$server_collection" <<EOF
{  
  "index_name": "$elasticsearch_index",
  "type_name": "doc",
  "id_path": "vessel.mmsi",
  "geometry_path": "course.segment.geometry.geometry",
  "centroid_path": "position.location",
  "timestamp_path": "position.timestamp"
}
EOF

export server_collection_name=ais-danmark

export WUI_configuration=/config.json
export WUI_map_configuration=/config.map.json

/base.bash
