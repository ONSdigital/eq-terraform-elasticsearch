#!/usr/bin/env bash

echo "Building Bulk List"
> data/occupations-bulk.json

# Occupations
jq -c '.[]' data/occupations.json | while read row; do
    echo "{\"index\" : {}}" >> data/occupations-bulk.json
    echo "{\"occupation\": $row }" >> data/occupations-bulk.json
done
