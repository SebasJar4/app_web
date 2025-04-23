#!/bin/bash
#set -e

cd /run/media/sebas/Docs/Universidad/programacion/project_web/mysql_server/db

date=$(date)
echo "Update started at ${date}" > log.txt 

output=$(mysql -u root -p < ./all.sql 2>&1)

if [[ $? -ne 0 ]]; then
    echo "Error en la ejecución: $output"
else
    echo "SQL ejecutado exitosamente."
    echo "Update successfully completed at ${date}" >> log.txt
fi