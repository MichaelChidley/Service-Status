#!/bin/bash

#Filename:      serviceStatus.sh
#Created:       08/02/2013
#Author:        MJC
#Modified:      -
#
#       2013


#Grab the first argument so this script is universal 
SERVICE=$1

if [ "$SERVICE" == "apache2" ]; then
        TOGREP="pid"
elif [ "$SERVICE" == "mysql" ]; then
        TOGREP="start/running"
elif [ "$SERVICE" == "vsftpd" ]; then
        TOGREP="start/running"
fi 
  
#Email address to notify
EMAIL="chiders@gmail.com";

#If the status of the service is running it will return a PID, so check that
if service $SERVICE status | grep "$TOGREP"
then
        echo ""

#if it is not found, initiate a restart of the service, and notify email address of the result
else
        #Initiate a start of the service and apply message content to the variable with the result   
        if service $SERVICE start   
        then
                RESULT="$SERVICE was found not to be running but successfully restarted!"
        else
                RESULT="$SERVICE was unable to start!"
        fi

        #Email the defined email address with the notice and results of restart
        echo "$RESULT" | mutt -s "$SERVICE STATUS" -- $EMAIL     
fi