#!/usr/bin/env bash

echo "Building Bulk List"
> data/countries-bulk.json

# Countries
jq -c '.[]' data/countries.json | while read row; do
    echo "{\"index\" : {}}" >> data/countries-bulk.json
    echo "{\"country\": $row }" >> data/countries-bulk.json
done