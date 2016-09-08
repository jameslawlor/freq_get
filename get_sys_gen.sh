#!/usr/bin/env bash

b=2016-01-01
e=2016-08-30

while [ "$b" != "$e" ]; do
	c=$(date -d "${b} 1 day" +%Y-%m-%d)

	echo "Processing $b"
	FROMDAY=$(date -d "$b" '+%d')
	FROMMONTH=$(date -d "$b" '+%b')
	FROMYEAR=$(date -d "$b" '+%Y')

	TODAY=$(date -d "$c" '+%d')
	TOMONTH=$(date -d "$c" '+%b')
	TOYEAR=$(date -d "$c" '+%Y')

    url="http://smartgriddashboard.eirgrid.com/DashboardService.svc/csv?area=generationActual&region=ALL&datefrom=${FROMDAY}-${FROMMONTH}-${FROMYEAR}%2000:00&dateto=${TODAY}-${TOMONTH}-${TOYEAR}%2023:59"

    outday=$(date -d "$b" '+%d')
    outmonth=$(date -d "$b" '+%m')
    outyear=$(date -d "$b" '+%Y')

	wget -O "${outyear}-${outmonth}-${outday}_gen.csv" $url

	b=$(date +%Y-%m-%d -d "$b +1 day")

done

