#!/usr/bin/env bash

echo "Building Bulk List"
> data/industries-bulk.json

# Industries
jq -c '.[]' data/industries.json | while read row; do
    echo "{\"index\" : {}}" >> data/industries-bulk.json
    echo "{\"industry\": $row }" >> data/industries-bulk.json
done
