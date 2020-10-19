#!/bin/bash

ES_URL="192.168.0.20:9200"
ES_IDX="agensedge"

echo "\b** 0) delete index : ${ES_URL}/${ES_IDX}"
curl -X DELETE "${ES_URL}/${ES_IDX}"
sleep 0.5

echo "\n** 1) create index : ${ES_URL}/${ES_IDX}"
curl -X PUT "${ES_URL}/${ES_IDX}" -H 'Content-Type: application/json' -d'
{}
'
sleep 0.5

echo "\n** 2) put mapping : ${ES_URL}/${ES_IDX}"
curl -X PUT "${ES_URL}/${ES_IDX}/_mapping/${ES_IDX}" -H 'Content-Type: application/json' -d'
{
  "dynamic": false,  
  "properties":{
    "timestamp"  : { "type" : "date", "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis" },
    "datasource" : { "type" : "keyword" },
    "id"         : { "type" : "keyword" },
    "label"      : { "type" : "keyword" },
    "properties" : {
      "type" : "nested",
      "properties": {
        "key"    : { "type" : "keyword" },
        "type"   : { "type" : "keyword" },
        "value"  : { "type" : "text", "fields":{ "keyword": {"type":"keyword", "ignore_above": 256} } }
      }
    },
    "src"        : { "type" : "keyword" },
    "dst"        : { "type" : "keyword" }
  }
}
'
sleep 0.5

echo "\n** 3) check index : ${ES_URL}"
curl -X GET "${ES_URL}/${ES_IDX}?pretty=true"

echo "\n  ..done, Good-bye\n"
