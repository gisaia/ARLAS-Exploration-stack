. conf/stack.env
echo "Fetch sample data"
curl https://raw.githubusercontent.com/gisaia/arlas_cli/master/tests/sample.json -o sample/sample.json
echo "Create mapping for courses"
arlas_cli --config-file /tmp/arlas-cli.yaml indices --config local mapping sample/sample.json --nb-lines 200 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --no-fulltext cargo_type --push-on org.com@courses
echo "Index courses"
arlas_cli --config-file /tmp/arlas-cli.yaml indices --config local data org.com@courses sample/sample.json
echo "Create courses collection"
#Get a token to create a collection
TOKEN="$(curl \
  -d "client_id=arlasm2m" \
  -d "client_secret=MmzaEUIqxpVOqA5G2dWZlAzoMRAKr8GH" \
  -d "grant_type=client_credentials" \
  "https://$ARLAS_HOST:9443/auth/realms/arlas/protocol/openid-connect/token" | jq -r '.access_token')"

  echo $TOKEN

#Create the colection 

curl -X 'PUT' \
  "http://$ARLAS_HOST/arlas/collections/courses?pretty=false&checkfields=true" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'accept: application/json;charset=utf-8' \
  -H 'Content-Type: application/json;charset=utf-8' \
  -d '{
    "index_name": "org.com@courses",
    "id_path": "track.id",
    "timestamp_path": "track.timestamps.center",
    "centroid_path": "track.location",
    "geometry_path": "track.trail",
    "organisations": {
      "owner": "",
      "shared": [
          ""
      ],
      "public": true
  }
}'
echo "Create dashboard"
export ARLAS_SERVER_URL="http://$ARLAS_HOST"
envsubst '$ARLAS_SERVER_URL' < sample/dashboard.json > sample/dashboard.generated.json

#Create a read only public dashboard
curl -X 'POST' \
  "http://$ARLAS_HOST/persist/persist/resource/config.json/Course%20Dashboard?readers=group%2Fpublic&pretty=false" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'accept: application/json;charset=utf-8' \
  -H 'Content-Type: application/json;charset=utf-8' \
  -d '@sample/dashboard.generated.json'