#!/bin/bash

export ES_URI="192.168.0.20:9200"
export ES_IDX_VERTEX="agensvertex"
export ES_IDX_EDGE="agensedge"
export ES_DATASOURCE="northwind"
export PG_URI="192.168.0.30:5432"
export PG_DATABASE="northwind"
export PG_USER="bitnine"
export PG_PASSWORD="bitnine"
export PG_DRIVER_PATH="/Users/bgmin/Workspaces/agenspop/logstash_test/drivers/postgresql-42.2.6.jar"

curl -X POST "${ES_URI}/${ES_IDX_VERTEX}/_delete_by_query?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "datasource": "'${ES_DATASOURCE}'"
    }
  }
}
'
sleep 0.5
curl -X POST "${ES_URI}/${ES_IDX_EDGE}/_delete_by_query?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "datasource": "'${ES_DATASOURCE}'"
    }
  }
}
'
sleep 1.5

echo ""
curl -X GET "${ES_URI}/_cat/indices?v"

echo "\n================================================="
echo "** Start bulk-insert to '${ES_IDX_VERTEX}', '${ES_IDX_EDGE}' ! \n"

echo "V1) logstash ==> northwind-vertex-category.conf"
logstash -f northwind-vertex-category.conf   > /dev/null
sleep 0.5

echo "V2) logstash ==> northwind-vertex-customer.conf"
logstash -f northwind-vertex-customer.conf   > /dev/null
sleep 0.5

echo "V3) logstash ==> northwind-vertex-employee.conf"
logstash -f northwind-vertex-employee.conf   > /dev/null
sleep 0.5

echo "V4) logstash ==> northwind-vertex-order.conf"
logstash -f northwind-vertex-order.conf      > /dev/null
sleep 0.5

echo "V5) logstash ==> northwind-vertex-product.conf"
logstash -f northwind-vertex-product.conf    > /dev/null
sleep 0.5

echo "V6) logstash ==> northwind-vertex-shipper.conf"
logstash -f northwind-vertex-shipper.conf    > /dev/null
sleep 0.5

echo "V7) logstash ==> northwind-vertex-supplier.conf"
logstash -f northwind-vertex-supplier.conf   > /dev/null
sleep 0.5

echo ""

echo "E1) logstash ==> northwind-edge-contains.conf"
logstash -f northwind-edge-contains.conf     > /dev/null
sleep 0.5

echo "E2) logstash ==> northwind-edge-part_of.conf"
logstash -f northwind-edge-part_of.conf      > /dev/null
sleep 0.5

echo "E3) logstash ==> northwind-edge-purchased.conf"
logstash -f northwind-edge-purchased.conf    > /dev/null
sleep 0.5

echo "E4) logstash ==> northwind-edge-reports_to.conf"
logstash -f northwind-edge-reports_to.conf   > /dev/null
sleep 0.5

echo "E6) logstash ==> northwind-edge-sold.conf"
logstash -f northwind-edge-sold.conf         > /dev/null
sleep 0.5

echo "E7) logstash ==> northwind-edge-ships.conf"
logstash -f northwind-edge-ships.conf        > /dev/null
sleep 0.5

echo "E8) logstash ==> northwind-edge-supplies.conf"
logstash -f northwind-edge-supplies.conf     > /dev/null
sleep 0.5

echo ""
curl -X GET "${ES_URI}/_cat/indices?v"

echo "\n ..done, Good-bye"
exit 0