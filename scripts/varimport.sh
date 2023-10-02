#!/bin/bash

docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_config_http.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_KATMC_RT_to_STG_GAL_KATMC_RT.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_KATSOPR_RT-STG_GAL_KATSOPR.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_KATSOPR_RT_to_STG_GAL_KATSOPR.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_KATSOPR_RT_to_STG_GAL_KATSOPR_RT.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_SPORDER_RT-STG_GAL_SPORDER.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_SPORDER_RT_to_STG_GAL_SPORDER.json
docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/nifi_http_configs/NIFI_SPORDER_RT_to_STG_GAL_SPORDER_RT.json
