#!/bin/sh

# Simple healthcheck which compares number of services registered in supervisord and the number of running services.

number_of_services=$(supervisorctl status |wc -l)
running_services=$(supervisorctl status |grep RUNNING |wc -l)

if [ ${number_of_services} -eq 0 ];then
    echo "Number of Services Running is 0"
    exit 1
fi

if [ ${number_of_services} -eq ${running_services} ];then
    exit 0
else
    echo "Number of services registered : ${number_of_services}"
    echo "Number of running services    : ${running_services}"
    exit 1
fi
