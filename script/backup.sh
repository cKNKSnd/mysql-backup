#!/bin/bash
echo 'Start backup data...'
/root/script/mysqlbak-medicine.sh
/root/script/mysqlbak-ts-service.sh
/root/script/mysqlbak-sport-service.sh
/root/script/mysqlbak-sport-task2.sh
echo 'end backing data..'