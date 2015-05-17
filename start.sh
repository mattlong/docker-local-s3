#!/bin/bash

docker-compose up data

docker-compose build swift3
docker-compose up swift3
