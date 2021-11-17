#! /bin/bash

curr_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo $curr_time

echo "start docker-compose"
docker-compose up | tee $curr_time-compose.log
echo "done.."
