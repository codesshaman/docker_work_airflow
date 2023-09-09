#!/bin/bash

# Проверяем папку dags
if diff -r dags/vars newdags/vars >/dev/null ; then
  echo "Переменные в папке newdags/vars не отличаются от файлов в папке dags/vars."
else
  # Создаем скрытый файл .changes или перезаписываем его содержимое
  diff -r dags/vars newdags/vars > .changes
  echo "Отличающиеся файлы записаны в .changes"
fi