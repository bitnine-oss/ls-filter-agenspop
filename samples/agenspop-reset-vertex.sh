#!/bin/bash

ES_URL="192.168.0.20:29200"
ES_IDX="agensvertex"
ES_USER="elastic"
ES_PASSWORD="bitnine"

echo -e "\n** 0) delete index : ${ES_URL}/${ES_IDX}"
curl -X DELETE "${ES_URL}/${ES_IDX}" -u $ES_USER:$ES_PASSWORD
sleep 0.5

echo -e "\n** 1) create index : ${ES_URL}/${ES_IDX}"
curl -X PUT "${ES_URL}/${ES_IDX}" -u $ES_USER:$ES_PASSWORD -H 'Content-Type: application/json' -d"{
\"mappings\": {
  \"dynamic\": false,
  \"properties\":{
    \"timestamp\"  : { \"type\" : \"date\", \"format\": \"yyyy-MM-dd'T'HH:mm:ss||yyyy-MM-dd||epoch_millis\" },
    \"datasource\" : { \"type\" : \"keyword\" },
    \"id\"         : { \"type\" : \"keyword\" },
    \"label\"      : { \"type\" : \"keyword\" },
    \"properties\" : {
      \"type\" : \"nested\",
      \"properties\": {
        \"key\"    : { \"type\": \"keyword\" },
        \"type\"   : { \"type\": \"keyword\" },
        \"value\"  : { \"type\" : \"text\", \"fields\":{ \"keyword\": {\"type\":\"keyword\", \"ignore_above\": 256} } }
      }
    }
  }
}}"
sleep 0.5

echo -e "\n** 3) check index : ${ES_URL}"
curl -X GET "${ES_URL}/${ES_IDX}?pretty=true" -u $ES_USER:$ES_PASSWORD

echo -e "\n  ..done, Good-bye\n"
