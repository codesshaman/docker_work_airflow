FROM apache/airflow:latest-python3.10

LABEL author="i.klimenko@askona.ru"

LABEL org.opencontainers.image.description="Image Apache Airflow for hosting on OpenShift platform" \
      org.opencontainers.image.title="Prodution Airflow Image" \
      org.opencontainers.image.ref.name="airflow-prod" \
      org.opencontainers.image.vendor="Askona" \
      org.opencontainers.image.licenses="Apache-2.0" 

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        alien \
        libaio1 \
        libgeos-c1v5 \
        libgeos-dev && \
    apt-get autoremove -yqq --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://download.oracle.com/otn_software/linux/instantclient/213000/oracle-instantclient-basiclite-21.3.0.0.0-1.el8.x86_64.rpm && \
    alien -i oracle-instantclient-basiclite-21.3.0.0.0-1.el8.x86_64.rpm && \
    rm -f oracle-instantclient-basiclite-21.3.0.0.0-1.el8.x86_64.rpm && \
    pip3 install --upgrade pip

USER airflow

RUN pip install airflow-providers-clickhouse apache-airflow-providers-ftp \
    apache-airflow-providers-jdbc apache-airflow-providers-jira \
    apache-airflow-providers-microsoft-mssql \
    apache-airflow-providers-neo4j apache-airflow-providers-odbc \
    apache-airflow-providers-oracle apache-airflow-providers-postgres \
    apache-airflow-providers-redis apache-airflow-providers-samba \
    apache-airflow-providers-sftp \
    apache-airflow-providers-ssh \
    apache-airflow-providers-telegram

COPY requirements.txt .

RUN pip3 install -r requirements.txt && \
    export ORACLE_HOME=/usr/lib/oracle/21/client64 && \
    export TNS_ADMIN=/etc && \
    export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib && \
    export PATH=$PATH:/usr/lib/oracle/21/client64/bin

CMD ["airflow", "standalone"]
