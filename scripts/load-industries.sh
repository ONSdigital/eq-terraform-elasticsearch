#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "Please provide Elasticsearch URL"
    exit 1
fi

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

curl -XDELETE $1'/industries?pretty'

curl -XPUT $1'/industries?pretty' -H "Content-Type: application/json" --data "@../indexes/industries.json"

# Industries
echo "Inserting Bulk List"
curl -XPOST $1'/industries/industry/_bulk' -H "Content-Type: application/json" --data-binary "@../data/industries-bulk.json"