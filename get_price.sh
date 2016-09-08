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

    url="http://smartgriddashboard.eirgrid.com/DashboardService.svc/csv?area=marketPrice&region=ALL&datefrom=${FROMDAY}-${FROMMONTH}-${FROMYEAR}%2000:00&dateto=${TODAY}-${TOMONTH}-${TOYEAR}%2023:59"
    #http://smartgriddashboard.eirgrid.com/DashboardService.svc/csv?area=marketPrice&region=ALL&datefrom=08-Sep-2016%2000:00&dateto=08-Sep-2016%2023:59

    outday=$(date -d "$b" '+%d')
    outmonth=$(date -d "$b" '+%m')
    outyear=$(date -d "$b" '+%Y')

    try=true

    while [ $try="$true" ];do
	    echo $try
        f="${outyear}-${outmonth}-${outday}_price.csv" 

        wget -O $f $url
    
        if [ -s $f ]; then
            let try=$false
        fi
        echo $try
    done

	b=$(date +%Y-%m-%d -d "$b +1 day")

done

