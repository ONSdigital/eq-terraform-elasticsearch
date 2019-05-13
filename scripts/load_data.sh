#!/usr/bin/env bash

set -ex

if [ -z "$1" ]
  then
    echo "Please provide Elasticsearch URL"
    exit 1
fi

for list in index-data/*.json;

do

    filename=${list##*/}
    index_name=${filename%.*}

    echo "Creating index ${index_name}"

    curl -XDELETE $1"/${index_name}?pretty"

    index=`sed "s/item/${index_name}/g" indexes/item.json`

    curl -XPUT $1"/${index_name}?pretty" -H "Content-Type: application/json" --data-binary "${index}"

    echo "Inserting Bulk List"
    curl -XPOST $1"/${index_name}/${index_name}/_bulk" -H "Content-Type: application/json" --data-binary "@${list}"

done
