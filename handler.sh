#!/usr/bin/env sh
exec >> /scripts/consul_watch.log
IFS=" "
while read a
do
    echo $a
done
