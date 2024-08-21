#!/bin/bash
set -o errexit -o pipefail

curl https://raw.githubusercontent.com/gisaia/arlas_cli/master/tests/sample.json -o sample/sample.json

arlas_cli indices --config local mapping sample/sample.json --nb-lines 200 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --no-fulltext cargo_type --push-on courses
arlas_cli indices --config local data courses sample/sample.json
arlas_cli collections --config local create courses --index courses --display-name courses --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center
arlas_cli persist  --config local add sample/dashboard.json config.json --name "Course Dashboard"
