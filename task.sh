#!/bin/bash

username=$DB_USER
password=$DB_PASSWORD

# Удаляем файлы, если они существуют
rm -f /tmp/ShopDB.sql
rm -f /tmp/ShopDBData.sql

# Экспорт базы данных ShopDB
mysqldump -u "$username" -p"$password" ShopDB --result-file=/tmp/ShopDB.sql
if [ $? -ne 0 ]; then
  echo "Ошибка при создании дампа ShopDB"
  exit 1
fi

# Импорт дампа в ShopDBReserve
mysql -u "$username" -p"$password" ShopDBReserve < /tmp/ShopDB.sql
if [ $? -ne 0 ]; then
  echo "Ошибка при импорте в ShopDBReserve"
  exit 1
fi

# Экспорт данных без структуры из ShopDB
mysqldump -u "$username" -p"$password" ShopDB --no-create-db --no-create-info --result-file=/tmp/ShopDBData.sql
if [ $? -ne 0 ]; then
  echo "Ошибка при создании дампа данных из ShopDB"
  exit 1
fi

# Импорт данных в ShopDBDevelopment
mysql -u "$username" -p"$password" ShopDBDevelopment < /tmp/ShopDBData.sql
if [ $? -ne 0 ]; then
  echo "Ошибка при импорте данных в ShopDBDevelopment"
  exit 1
fi

echo "Скрипт выполнен успешно!"
