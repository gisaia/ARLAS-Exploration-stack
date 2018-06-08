This tutorial will show you how to initialize ARLAS with a custom set of data.

TODO: table of content

In this tutorial, we will use this set of data made of 3 randomly generated positions:

```bash
cat > data_file.csv <<EOF
02/05/2018 00:00:00;a;-69;134
03/05/2018 00:00:00;b;10;63
04/05/2018 00:00:00;c;-6;47
EOF
```

### Have ARLAS running

Follow instructions in the README.

TODO: link

### Set environment variables

```bash
export data_file=/data_file.csv \
       elasticsearch=http://elasticsearch:9200 \
       elasticsearch_index=my-data \
       elasticsearch_mapping=/elasticsearch_mapping.json \
       logstash_configuration=/logstash_configuration.conf \
       server=http://arlas-server:9999 \
       server_collection=/server_collection.json \
       server_collection_name=my-data \
       WUI_configuration=/WUI_configuration.json \
       WUI_map_configuration=/WUI_map_configuration.json
```

### Write the server collection

A collection is an ARLAS object that references your data indexed into elasticsearch. This is the server collection we will use for our set of data:

```bash
cat > server_collection.json <<EOF

{  
  "index_name": "$elasticsearch_index",
  "type_name": "doc",
  "id_path": "identifier",
  "geometry_path": "location",
  "centroid_path": "location",
  "timestamp_path": "timestamp"
}

EOF
```

### Write the elasticsearch mapping

You need to define a mapping to index your data in elasticsearch. Your indexed data are partially specified by the collection you created earlier:

- The mapping should define a `doc` type
- The doc type should contain fields
  - `identifier`
  - `location`
  - `timestamp`

```bash
cat > elasticsearch_mapping.json <<'EOF'

{
  "mappings": {
    "doc": {
      "dynamic": false,
      "properties": {
        "identifier": {
            "type": "keyword"
        },
        "name": {
          "type": "keyword"
        },
        "location": {
          "type": "geo_point"
        },
        "timestamp": {
          "format": "dd/MM/yyyy HH:mm:ss",
          "type": "date"
        }
      }
    }
  }
}

EOF
```

ARLAS requires you to index the Latitude/Longitude of your data under type `geo_point`.

### Write the logstash configuration for data indexation

Logstash is a data processing pipeline. We will use it to transform & index our raw data into elasticsearch.

```bash
cat > logstash_configuration.conf <<'EOF'

input {
  stdin {}
}

filter {
  csv {
    # Specification of the csv fields we will receive as input
    columns => [timestamp,name,latitude,longitude]
    separator => ";"
    convert => {
      "latitude" => "float"
      "longitude" => "float"
    }
  }
  mutate {
    # Fill elasticsearch field "location" of type "geo_point"
    rename => { "latitude" => "[location][lat]" }
    rename => { "longitude" => "[location][lon]" }
  }
  # Generate unique identifier for each of our positions
  uuid {
    target => "identifier"
    overwrite => true
  }
}

# Output to elasticsearch
# Values will be substitued at runtime by the environment variables we will set later on
output {
  elasticsearch {
    hosts => ["${elasticsearch}"]
    index => "${elasticsearch_index}"
  }
}

EOF
```

### Write WUI configuration

You need to shape ARLAS WUI (Web User Interface) so that it fits your data. For that purpose, ARLAS WUI is configurable through two configuration files:
- general configuration file
- map-specific configuration file

#### General configuration

```bash
cat >WUI_configuration.json <<'EOF'

{
  "arlas": {
    "server": {
      "collection": {
        "id": "identifier",
        "name": "my-data"
      },
      "max_age_cache": 120,
      "url": ""
    },
    "web": {
      "analytics": [
        {
          "components": [
            {
              "componentType": "resultlist",
              "contributorId": "table",
              "input": {
                "actionOnItemEvent": null,
                "consultedItemEvent": null,
                "defautMode": "list",
                "detailedGridHeight": 25,
                "displayFilters": false,
                "globalActionEvent": null,
                "globalActionsList": [],
                "isBodyHidden": false,
                "isGeoSortActived": false,
                "nLastLines": 3,
                "nbGridColumns": 3,
                "searchSize": 20,
                "selectedItemsEvent": null,
                "tableWidth": null
              }
            }
          ],
          "groupId": "9",
          "icon": "list",
          "title": "Result List"
        }
      ],
      "components": {
        "mapgl": {
          "input": {
            "idFeatureField": "identifier",
            "mapLayers": {
              "events": {
                "emitOnClick": [
                  "cluster-rect-fill"
                ],
                "onHover": [
                  "cluster-rect-fill"
                ],
                "zoomOnClick": [
                  "cluster-rect-fill"
                ]
              },
              "layers": [],
              "styleGroups": [
                {
                  "base": [
                    "geobox",
                    "feature-line",
                    "features-symbol"
                  ],
                  "id": "cluster",
                  "name": "Cluster",
                  "styles": [
                    {
                      "id": "heat",
                      "isDefault": false,
                      "layerIds": [
                        "cluster-heat"
                      ],
                      "name": "Heats"
                    },
                    {
                      "id": "fill",
                      "isDefault": true,
                      "layerIds": [
                        "cluster-rect-fill"
                      ],
                      "name": "Rectangle"
                    }
                  ]
                }
              ]
            },
            "margePanForLoad": 40,
            "margePanForTest": 2,
            "style": "https://openmaptiles.github.io/osm-bright-gl-style/style-cdn.json"
          }
        },
        "share": {
          "geojson": {
            "max_for_cluster": 100000,
            "max_for_feature": 10000,
            "sort_excluded_type": [
              "TEXT",
              "GEO_POINT"
            ]
          }
        },
        "timeline": {
          "input": {
            "brushHandlesHeightWeight": 0.8,
            "chartHeight": 100,
            "chartTitle": "Number of positions over time",
            "customizedCssClass": "arlas-timeline",
            "id": "histogram-timeline",
            "multiselectable": true,
            "xLabels": 7,
            "xTicks": 7,
            "yLabels": 2,
            "yTicks": 2
          }
        }
      },
      "contributors": {
        "chipssearch$chipssearch": {
          "icon": "search",
          "identifier": "chipssearch",
          "name": "Search",
          "search_field": "internal.fulltext",
          "search_size": 100
        },
       "histogram$timeline": {
          "aggregationmodels": [
            {
              "field": "location.timestamp",
              "interval": {
                "unit": "minute",
                "value": 1
              },
              "type": "datehistogram"
            }
          ],
          "datatype": "time",
          "dateunit": "second",
          "icon": "watch_later",
          "identifier": "timeline",
          "isOneDimension": false,
          "name": "Timeline"
        },
        "map$mapbox": {
          "actions": {
            "flyto": true,
            "hightlight": true
          },
          "aggregationmodels": [
            {
              "field": "location",
              "interval": {
                "value": 3
              },
              "type": "geohash",
              "withGeoCentroid": true
            }
          ],
          "drawtype": "RECTANGLE",
          "geometry": "geometry",
          "icon": "check_box_outline_blank",
          "idFieldName": "identifier",
          "identifier": "mapbox",
          "initZoom": 4,
          "maxPrecision": [
            7,
            4
          ],
          "name": "Map",
          "nbMaxDefautFeatureForCluster": 10000,
          "search_size": 10000,
          "zoomLevelForTestCount": 6,
          "zoomLevelFullData": 6,
          "zoomToNbMaxFeatureForCluster": [
            [
              4,
              10000
            ],
            [
              5,
              10000
            ],
            [
              6,
              10000
            ],
            [
              7,
              10000
            ],
            [
              8,
              10000
            ],
            [
              9,
              10000
            ],
            [
              10,
              10000
            ],
            [
              11,
              10000
            ],
            [
              12,
              10000
            ]
          ],
          "zoomToPrecisionCluster": [
            [
              0,
              3,
              1
            ],
            [
              1,
              3,
              1
            ],
            [
              2,
              3,
              1
            ],
            [
              3,
              3,
              1
            ],
            [
              4,
              3,
              1
            ],
            [
              5,
              4,
              2
            ],
            [
              6,
              4,
              2
            ],
            [
              7,
              4,
              2
            ],
            [
              8,
              5,
              3
            ],
            [
              9,
              6,
              4
            ],
            [
              10,
              7,
              4
            ],
            [
              11,
              7,
              5
            ],
            [
              12,
              7,
              5
            ],
            [
              13,
              7,
              5
             ],
            [
              14,
              8,
              5
            ],
            [
              15,
              8,
              5
            ],
            [
              16,
              8,
              5
            ],
            [
              17,
              8,
              5
            ],
            [
              18,
              8,
              5
            ],
            [
              19,
              8,
              5
            ],
            [
              20,
              8,
              5
            ]
          ]
        },
        "resultlist$table": {
          "columns": [
            {
              "columnName": "id",
              "dataType": "",
              "fieldName": "identifier",
              "process": ""
            },
            {
              "columnName": "name",
              "dataType": "",
              "fieldName": "name",
              "process": ""
            }
          ],
          "details": [],
          "fieldsConfiguration": {
            "idFieldName": "identifier"
          },
          "icon": "list",
          "identifier": "table",
          "name": "Detail list",
          "process": {
            "urlImageTemplate": {
              "process": ""
            },
            "urlThumbnailTemplate": {
              "process": ""
            }
          },
          "search_size": 20
        }
      }
    }
  },
  "arlas-wui": {
    "web": {
      "app": {
        "components": {
          "chipssearch": {
            "autocomplete_field": "name",
            "autocomplete_size": "20",
            "icon": "search",
            "name": "Search",
            "search_size": 100
          }
        },
        "idFieldName": "id"
      }
    }
  },
  "extraConfigs": [
    {
      "configPath": "config.map.json",
      "replacedAttribute": "arlas.web.components.mapgl.input.mapLayers.layers",
      "replacer": "layers"
    }
  ]
}

EOF
```

#### Map-specific configuration

```bash
cat >WUI_map_configuration.json <<'EOF'

{
  "layers": [
    {
      "filter": [
        "==",
        "$type",
        "Polygon"
      ],
      "id": "cluster-rect-fill",
      "layout": {
        "visibility": "visible"
      },
      "paint": {
        "fill-color": {
          "property": "point_count_normalize",
          "stops": [
            [
              0,
              "#36a996"
            ],
            [
              20,
              "#3683a9"
            ],
            [
              40,
              "#3649a9"
            ],
            [
              60,
              "#5c36a9"
            ],
            [
              80,
              "#9636a9"
            ],
            [
              100,
              "#a93683"
            ]
          ],
          "type": "exponential"
        },
        "fill-opacity": 0.7
      },
      "source": "data_source",
      "type": "fill"
    },
    {
      "filter": [
        "all",
        [
          "!has",
          "point_count"
        ],
        [
          "==",
          "$type",
          "Point"
        ]
      ],
      "id": "features-point",
      "paint": {},
      "source": "data_source",
      "type": "circle"
    },
    {
      "id": "geobox",
      "layout": {
        "visibility": "visible"
      },
      "paint": {
        "line-color": "#5c36a9",
        "line-opacity": 1,
        "line-width": 2
      },
      "source": "geobox",
      "type": "line"
    }
  ]
}

EOF
```

### Perform data initialization

```bash
docker run -e data_file -e elasticsearch -e elasticsearch_index -e elasticsearch_mapping -e logstash_configuration -e server -e server_collection -e server_collection_name -e WUI_configuration -e WUI_map_configuration --net arlas --rm -t \
  --mount dst="$data_file",src="$PWD/data_file.csv",type=bind \
  --mount dst="$elasticsearch_mapping",src="$PWD/elasticsearch_mapping.json",type=bind \
  --mount dst="$logstash_configuration",src="$PWD/logstash_configuration.conf",type=bind \
  --mount dst="$server_collection",src="$PWD/server_collection.json",type=bind \
  --mount dst="$WUI_configuration",src="$PWD/WUI_configuration.json",type=bind \
  --mount dst="$WUI_map_configuration",src="$PWD/WUI_map_configuration.json",type=bind \
  --mount type=volume,src=arlasstack_wui-configuration,dst=/wui-configuration \
  gisaia/arlas-init-base
```