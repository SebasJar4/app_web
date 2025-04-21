#!/bin/bash
cd /run/media/sebas/Docs/Universidad/programacion/project_web/

# --- Leer argumentos tipo clave=valor ---
expo_platform=""
for arg in "$@"; do
  case $arg in
    expo=*)
      value="${arg#*=}"
      case "$value" in
        start|-s) expo_platform="start" ;;
        android|-a) expo_platform="android" ;;
        ios|-i) expo_platform="ios" ;;
        web|-w) expo_platform="web" ;;
        *)
          echo "❌ Plataforma inválida para expo: $value"
          echo "Opciones válidas: start (-s), android (-a), ios (-i), web (-w)"
          exit 1
          ;;
      esac
      ;;
    *)
      echo "❌ Argumento desconocido: $arg"
      exit 1
      ;;
  esac
done

if [ -z "$expo_platform" ]; then
  echo "⚠️ No se paso ningun argumento por endo se obviara por defecto y expo se iniciará en la opcion web"
  expo_platform=web
fi

fecha_formateada=$(date +"%d-%m-%Y")
ext=".log"

cd ./yourPlaceSafed/ || { echo "❌ Carpeta yourPlaceSafed no encontrada"; exit 1; }

mkdir -p ./logs

# ---------- Expo ----------
baseNameExpo="expo_${expo_platform}_server_"
counter=0
while [ -e "./logs/${baseNameExpo}${counter}_(${fecha_formateada})${ext}" ]; do
    ((counter++))
done
nameLogExpo="${baseNameExpo}${counter}_(${fecha_formateada})${ext}"
logPathExpo="./logs/$nameLogExpo"

if pgrep -f "pnpm run" > /dev/null; then
    pid=$(pgrep -f "pnpm run ")
    echo "⚠️ Expo ya se está ejecutando (PID: $pid)"
else
    nohup pnpm run $expo_platform > "$logPathExpo" >&1 &
    pid=$!
    echo "🚀 Expo ($expo_platform) iniciado (PID: $pid) | Log: $logPathExpo"
fi

cd ../

# ---------- PHP ----------
mkdir -p ./backend/logs
baseNamePhp="php_server_"
counterPhp=0
while [ -e "./backend/logs/${baseNamePhp}${counterPhp}_(${fecha_formateada})${ext}" ]; do
    ((counterPhp++))
done
nameLogPhp="${baseNamePhp}${counterPhp}_(${fecha_formateada})${ext}"
logPathPhp="./backend/logs/$nameLogPhp"

if lsof -i :8000 | grep LISTEN > /dev/null; then
    pid=$(lsof -ti :8000)
    echo "⚠️ PHP ya está ejecutándose en el puerto 8000 (PID: $pid)"
else
    nohup php -S localhost:8000 -t ./backend/api/ > "$logPathPhp" >&1 &
    pid=$!
    echo "🚀 PHP iniciado (PID: $pid) | Log: $logPathPhp"
fi

# ---------- MySQL ----------
if pgrep -x "mysqld" > /dev/null; then
    pid=$(pgrep -x "mysqld")
    echo "⚠️ MySQL ya se está ejecutando (PID: $pid)"
else
    echo "🚀 Iniciando MySQL..."
    systemctl start mysqld
    sleep 2
    if pgrep -x "mysqld" > /dev/null; then
        pid=$(pgrep -x "mysqld")
        echo "✅ MySQL iniciado (PID: $pid)"
    else
        echo "❌ Error: No se pudo iniciar MySQL"
    fi
fi

code yourPlaceSafed/$logPathExpo $logPathPhp