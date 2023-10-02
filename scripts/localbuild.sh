#!/bin/bash

generate_random_string() {
    length=$1
    characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    str=""
    for ((i=0; i<$length; i++)); do
        rand_index=$((RANDOM % ${#characters}))
        rand_char=${characters:$rand_index:1}
        str="$str$rand_char"
    done
    echo $str
}

commit_length=40  # Длина коммита (обычно 40 символов для SHA-1)
image_name="gitlab.askona.ru:5005/dp-data-platform/airflow"
random_commit=$(generate_random_string $commit_length)

export CI_REGISTRY_IMAGE=$image_name
export CI_COMMIT_SHA=$random_commit
export SELFMADE_AIRFLOW_IMAGE="$image_name:$random_commit"
echo $image_name:$random_commit
docker build --no-cache -t ${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHA} .
docker images
echo "Теперь вручную выполните следующую команду:"
echo "export SELFMADE_AIRFLOW_IMAGE=${image_name}:${random_commit}"
