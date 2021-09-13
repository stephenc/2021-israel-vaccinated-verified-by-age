# Israel vaccinated-verified-by-age data collector

This GitHub repo captures the vaccinated-verified-by-age data from [datadashboard.health.gov.il](https://datadashboard.health.gov.il/COVID-19/general) twice per day.

The [`vaccinated-verified-by-age.csv`](./vaccinated-verified-by-age.csv) file gets updated as part of the capture.

Data for 2021-08-11 through 2021-08-18 were manually scraped as XSLX files thanks to Oded and the XLSX files are missing three columns (which could be inferred from the ratio of normalized to amount)

## Data Query changed after 2021-09-05 07:03:02 UTC

New query reflects somewhat different data and the column names have been changed to reflect the difference (I may try and unify the column names once we establish which columns have equivalence to the old ones)

It appears that the vaccinated column has been cleanly split to separate out those that have received 3 shots.
There are still mysteries as to where the partially vaccinated column has been integrated, also the normalization denominators have changed for the unvaccinated 
