#!/bin/bash

cd ./yourPlaceSafed/

# Asegurar carpeta logs
mkdir -p ./logs

# ---------- Expo ----------
baseNameExpo="expo_web"
ext=".log"
nameLogExpo="$baseNameExpo$ext"
counter=0

while [ -e "./logs/$nameLogExpo" ]; do
    ((counter++))
    nameLogExpo="${baseNameExpo}${counter}${ext}"
done

if pgrep -f "pnpm run web" > /dev/null; then
    pid=$(pgrep -f "pnpm run web")
    echo "⚠️ Expo ya se está ejecutando (PID: $pid)"
else
    nohup pnpm run web > "./logs/$nameLogExpo" 2>&1 &
    pid=$!
    echo "🚀 Expo iniciado (PID: $pid) | Log: ./logs/$nameLogExpo"
fi

cd ../

# ---------- PHP ----------
baseNamePhp="php_server"
nameLogPhp="$baseNamePhp$ext"
counterPhp=0

while [ -e "./yourPlaceSafed/logs/$nameLogPhp" ]; do
    ((counterPhp++))
    nameLogPhp="${baseNamePhp}${counterPhp}${ext}"
done

if lsof -i :8000 | grep LISTEN > /dev/null; then
    pid=$(lsof -ti :8000)
    echo "⚠️ PHP ya está ejecutándose en el puerto 8000 (PID: $pid)"
else
    nohup php -S localhost:8000 -t ./yourPlaceSafed/backend/api > "./yourPlaceSafed/logs/$nameLogPhp" 2>&1 &
    pid=$!
    echo "🚀 PHP iniciado (PID: $pid) | Log: ./yourPlaceSafed/logs/$nameLogPhp"
fi

# ---------- MySQL ----------
if pgrep -x "mysqld" > /dev/null; then
    pid=$(pgrep -x "mysqld")
    echo "⚠️ MySQL ya se está ejecutando (PID: $pid)"
else
    echo "🚀 Iniciando MySQL..."
    sudo systemctl start mysql
    sleep 2
    if pgrep -x "mysqld" > /dev/null; then
        pid=$(pgrep -x "mysqld")
        echo "✅ MySQL iniciado (PID: $pid)"
    else
        echo "❌ Error: No se pudo iniciar MySQL"
    fi
fi
