#!/bin/bash

# Проверяем наличие файла .changes
if [ ! -f .changes ]; then
  echo "Файл .changes не найден."
  exit 1
fi

# Проходим по каждой строке в файле .changes
while read -r line; do
  # Ищем строки, начинающиеся с "diff" — они указывают на измененные файлы
  if [[ $line == diff* ]]; then
    # Извлекаем и печатаем путь к измененному файлу только если он имеет расширение .json
    file=${line#* }
    if [[ $file == *.json ]]; then
      words=($file)
      num_words=${#words[@]}
      result=${words[$((num_words-1))]}
      echo "${result:3}"
    fi
  fi
done < .changes

while read -r line; do
  # Ищем строки, начинающиеся с "Only in" — они указывают на отсутствующие файлы
  if [[ $line == Only* ]]; then
    # Извлекаем и печатаем путь к измененному файлу только если он имеет расширение .json
    file=${line#* }
    if [[ $file == *.json ]]; then
      # echo "$file"
      words=($file)
      string=${file#* }
      result=${string/: /\/}
      echo "${result:3}"
    fi
  fi
done < .changes