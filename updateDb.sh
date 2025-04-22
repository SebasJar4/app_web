#!/bin/bash

cd /run/media/sebas/Docs/Universidad/programacion/project_web/backend/db
mysql -u root -p < ./all.sql
echo "Termino de subir la base de datos ;D"