#!/usr/bin/env bash

set -e
set -o pipefail

if [[ $OSTYPE == 'darwin'* ]]; then
	alias sha256sum=gsha256sum
fi

export SCRAPE_DATE="$(TZ=UTC printf '%(%Y-%m-%d_%H.%M.%S)TZ\n')"

if [ ! -d data ]
then
	mkdir -p data
fi

curl -fsSL 'https://datadashboardapi.health.gov.il/api/queries/_batch' \
    -H 'Accept: application/json' \
    --compressed \
    -H 'Content-Type: application/json' \
    --data-raw '{"requests":[{"id":"0","queryName":"VaccinationStatusAgg","single":false,"parameters":{}}]}' \
    > tmp.json

>&2 echo "[INFO] Scraped data:"
jq . tmp.json

export CONTENT_HASH=$(sha256sum tmp.json | sed -e 's/ .*$//')

if sha256sum data/*.json | grep -F "${CONTENT_HASH}" >> /dev/null 
then
	>&2 echo "[INFO] Data already captured"
	rm -f tmp.json
else
	>&2 echo "[INFO] Persisting new data"
	mv -f tmp.json "data/scrape-${SCRAPE_DATE}.json"
	git add "data/scrape-${SCRAPE_DATE}.json"
fi

>&2 echo "[INFO] Done"