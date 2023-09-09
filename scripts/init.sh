#!/bin/bash

mkdir -p ./dags ./logs ./plugins ./config

cp .env.example .env

echo -e "AIRFLOW_UID=$(id -u)" >> .env
