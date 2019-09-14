#!/bin/sh

# Simple healthcheck which compares number of services registered in supervisord and the number of running services.

echo "$(date) : $(supervisorctl status)" >> /tmp/health.log

number_of_services=$(supervisorctl status |wc -l)
running_services=$(supervisorctl status |grep RUNNING |wc -l)

if [ ${number_of_services} -eq 0 ];then
    exit 1
fi

if [ ${number_of_services} -eq ${running_services} ];then
    exit 0
else
    exit 1
fi
