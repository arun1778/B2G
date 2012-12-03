#!/system/bin/sh
#
# * =============================================================================
# * Copyright (C) 2011 Intel Mobile Communications GmbH
# * =============================================================================
#
#----------------------------------------------------------------------------
INTERVAL=$1
FILE=$2
while true; do
	TS=`date`
	echo "Begin $TS" >> $FILE
	ps -t | busybox awk '{print $2 " " $3 " " $4 " " $5 " " $9}' >> $FILE
	TS=`date`
	echo "End $TS" >> $FILE
	sleep $INTERVAL
done
