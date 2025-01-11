#! /bin/bash
username=$DB_USER
password=$DB_PASSWORD
rm /tmp/ShopDB.sql
rm /tmp/ShopDBData.sql

mysqldump -u $username -p$password ShopDB --result-file=/tmp/ShopDB.sql
mysql -u $username -p$password ShopDBReserve < /tmp/ShopDB.sql

mysqldump -u $username -p$password ShopDB --no-create-db --no-create-info --result-file=/tmp/ShopDBData.sql
mysql -u $username -p$password ShopDBDevelopment < /tmp/ShopDBData.sql#! /bin/bash
