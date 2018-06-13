This tutorial aims at explaining how to initialize ARLAS with a custom set of data.

**Table of content**

[Have ARLAS running](#have-arlas-running)

[Write the server collection](#write-the-server-collection)

[Write the elasticsearch mapping](#write-the-elasticsearch-mapping)

[Write the logstash configuration for data indexation](#write-the-logstash-configuration-for-data-indexation)

[Write WUI configuration](#write-wui-configuration)
  - [General configuration](#general-configuration)
  - [Map-specific configuration](#map-specific-configuration)

[Perform data initialization](#perform-data-initialization)

In this tutorial, we will use this micro set of data made of 3 positions:

```bash
cat > data <<'EOF'
02/05/2018 00:00:00;a;48.856162;2.351855
03/05/2018 00:00:00;b;35.708808;139.731856
04/05/2018 00:00:00;c;40.711274;-74.006758
EOF
```

- **a**: somewhere in Paris
- **b**: somewhere in Tokyo
- **c**: somewhere in New York

### Have ARLAS running

[Follow related instructions in README](../README.md#usage).

### Write the server collection

A collection is an ARLAS object that references your data indexed into elasticsearch, see the relative documentation [here](http://arlas.io/arlas-tech/current/arlas-collection-model/). This is the server collection we will use for our set of data:

```bash
cat > server_collection.json <<EOF
{  
  "index_name": "data",
  "type_name": "doc",
  "id_path": "identifier",
  "geometry_path": "position",
  "centroid_path": "position",
  "timestamp_path": "timestamp"
}
EOF
```

### Write the elasticsearch mapping

You need to define a mapping to index your data in elasticsearch. Your indexed data are partially specified by the collection you created earlier, it should contain fields:

- `identifier`
- `position`
- `timestamp`

Also, ARLAS requires you to index the latitude/longitude of your data under type `geo_point`.

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
        "position": {
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

### Write the logstash configuration for data indexation

Logstash is a data processing pipeline. We will use it to transform & index our raw data into elasticsearch.

```bash
cat > logstash_configuration <<'EOF'
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
    # Fill elasticsearch field "position" of type "geo_point"
    rename => { "latitude" => "[position][lat]" }
    rename => { "longitude" => "[position][lon]" }
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

See [here](http://arlas.io/arlas-tech/current/arlas-wui-configuration/) for the relative documentation.

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
                    "features-point",
                    "geobox"
                  ],
                  "id": "cluster",
                  "name": "Cluster",
                  "styles": [
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
        "histogram$timeline": {
          "aggregationmodels": [
            {
              "field": "position.timestamp",
              "interval": {
                "unit": "day",
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
              "field": "position",
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
          "includeFeaturesFields": [
            "course.heading",
            "course.sog"
          ],
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
        "components": { },
        "idFieldName": "identifier"
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
docker run \
  --mount dst="/initialization",src="$PWD",type=bind \
  --mount type=volume,src=arlasstack_wui-configuration,dst=/wui-configuration \
  --net arlas --rm -t \
  gisaia/arlas-initializer
```
