#!/usr/bin/env bash

set -e
set -o pipefail

for file in data/scrape-*.json 
do
	export CAPTURE_TS="$(echo $file | sed -n -e 's/.*scrape-\([0-9]\{4\}-[0-2][0-9]-[0-3][0-9]\)_\([0-2][0-9]\).\([0-5][0-9]\).\([0-5][0-9]\)[Zz]\.json$/\1T\2:\3:\4Z/p')"
	if [ -z "$CAPTURE_TS" ]
	then
		echo "Malformed timestamp for $file, skipped" 1&>2
		continue
	fi
	jq -r '.[0].data | . | map(. + {capture_date_time:"'"$CAPTURE_TS"'"})' $file 
done | jq -s -r 'add | (map(keys) | add | unique ) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols , $rows[] | @csv' > vaccinated-verified-by-age.csv

git add vaccinated-verified-by-age.csv