#!/bin/bash

echo -e "\033[31mCleanup\033[0m"
docker stop queue-work || true
docker stop queue-listen || true

echo -e "\033[31mBuilding docker images\033[0m"
docker build -t queue-work -f artisan-queue-work.docker .
docker build -t queue-listen -f artisan-queue-listen.docker .

echo -e "\033[31mStarting containers\033[0m"
docker run --rm -d --name queue-work queue-work
docker run --rm -d --name queue-listen queue-listen

echo -e "\033[31mStopping container running queue:work\033[0m"
time docker stop queue-work

echo -e "\033[31mStopping container running queue:listen\033[0m"
time docker stop queue-listen
