#!/bin/bash

repo="gitlab.askona.ru:5005/dp-data-platform/airflow"
tag=$(docker images | grep ${repo} | awk '{print $2}')

echo $tag