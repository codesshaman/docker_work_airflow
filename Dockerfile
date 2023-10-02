FROM apache/airflow:latest-python3.10
USER root
LABEL author="i.klimenko@askona.ru"
LABEL org.opencontainers.image.description="Image Apache Airflow for hosting on OpenShift platform" \
      org.opencontainers.image.title="Prodution Airflow Image" \
      org.opencontainers.image.ref.name="airflow-prod" \
      org.opencontainers.image.vendor="Askona" \
      org.opencontainers.image.licenses="Apache-2.0" 

RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    wget \
    unzip \
    alien \
    libaio1 \
    libgeos-c1v5 \
    libgeos-dev wget && \
    apt-get autoremove -yqq --purge && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
USER airflow
RUN pip install --upgrade pip && \
    pip install airflow-providers-clickhouse apache-airflow-providers-ftp \
    apache-airflow-providers-oracle apache-airflow-providers-postgres \
    apache-airflow-providers-jdbc apache-airflow-providers-jira \
    apache-airflow-providers-neo4j apache-airflow-providers-odbc \
    apache-airflow-providers-redis apache-airflow-providers-samba \
    apache-airflow-providers-microsoft-mssql \
    apache-airflow-providers-telegram \
    apache-airflow-providers-sftp \
    apache-airflow-providers-ssh
COPY requirements.txt .
RUN pip3 install -r requirements.txt && \
    export ORACLE_HOME=/usr/lib/oracle/21/client64 && \
    export TNS_ADMIN=/etc && \
    export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib && \
    export PATH=$PATH:/usr/lib/oracle/21/client64/bin
