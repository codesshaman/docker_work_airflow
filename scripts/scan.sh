#!/bin/bash

output_file="./scripts/varimport.sh"  # Имя файла для записи путей
dir="./dags/vars"  # Путь к папке, которую нужно просканировать
prefix="docker-compose -f ./docker-compose.yml run --rm airflow-cli airflow variables import /opt/airflow/dags/vars/" # Префикс файла

# Создать или очистить файл перед записью
touch "$output_file"
echo "#!/bin/bash" > "$output_file"
echo "" >> "$output_file"

# Рекурсивно просканировать папку и записать пути в файл
scan_directory() {
  local current_dir="$1"  # Текущая папка
  
  # Перебрать все файлы и подкаталоги в текущей папке
  for file in "$current_dir"/*; do
    if [ -d "$file" ]; then
      # Если это подкаталог, рекурсивно вызвать эту функцию для него
      scan_directory "$file"
    elif [ -f "$file" ]; then
      # Если это файл, вычислить относительный путь и записать его в файл
      relative_path=${file#"$dir/"}  # Вычислить относительный путь
      echo "$prefix$relative_path" >> $output_file # Записать путь в файл
    fi
  done
}

# Вызвать функцию для начала сканирования
scan_directory "$dir"

echo "Все пути файлов были записаны в файл '$output_file'."