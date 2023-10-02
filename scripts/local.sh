#!/bin/bash

repo="gitlab.askona.ru:5005/dp-data-platform/airflow"
tag=$(docker images | grep ${repo} | awk '{print $2}')

echo "Теперь вручную выполните следующую команду:"
echo "export SELFMADE_AIRFLOW_IMAGE=${repo}:${tag}"