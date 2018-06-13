#!/bin/bash -e

export elasticsearch_index=ais-danmark
export server_collection_name=ais-danmark

cat > "/initialization/server_collection.json" <<EOF
{  
  "index_name": "$elasticsearch_index",
  "type_name": "doc",
  "id_path": "vessel.mmsi",
  "geometry_path": "course.segment.geometry.geometry",
  "centroid_path": "position.location",
  "timestamp_path": "position.timestamp"
}
EOF

/base.bash
