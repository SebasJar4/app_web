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
  echo "⚠️ No se pasó ningún argumento, por lo tanto se usará 'web' por defecto"
  expo_platform="web"
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

if pgrep -f "pnpm run $expo_platform" > /dev/null; then
    pid=$(pgrep -f "pnpm run $expo_platform")
    echo "⚠️ Expo ya se está ejecutando (PID: $pid)"
else
    echo "🏁 Expo ($expo_platform) iniciando ⚙️"

    gnome-terminal -- bash -c "
        cd /run/media/sebas/Docs/Universidad/programacion/project_web/yourPlaceSafed
        echo 'iniciando expo 🛂 con terminal interactiva...'
        script -c 'pnpm run $expo_platform' '$logPathExpo'
        echo '🛑 El proceso ha finalizado. Presiona cualquier tecla para salir...'
        read -n 1
        exec bash
    "

    echo "🚀 Expo ($expo_platform) iniciado | Log: $logPathExpo"
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

# Obtener la IP del PC
ip_address=$(hostname -I | awk '{print $1}')
php_port=8000
echo "IP de la máquina: $ip_address"

if lsof -i :$php_port | grep LISTEN > /dev/null; then
    pid=$(lsof -ti :$php_port)
    echo "⚠️ PHP ya está ejecutándose en el puerto $php_port (PID: $pid)"
else
    nohup php -S $ip_address:$php_port -t ./backend/api/ > "$logPathPhp" 2>&1 &
    pid=$!
    echo "🚀 PHP iniciado (PID: $pid) | Log: $logPathPhp"
fi

# ---------- Actualizar rute.json ----------
rute_json_path="/run/media/sebas/Docs/Universidad/programacion/project_web/yourPlaceSafed/services/rute.json"

# Usar jq para actualizar el archivo rute.json con la IP y puerto
if [ -f "$rute_json_path" ]; then
    echo "Actualizando rute.json con la IP $ip_address y el puerto $php_port..."
    jq ".host = \"$ip_address:$php_port/\"" "$rute_json_path" > temp_rute.json && mv temp_rute.json "$rute_json_path"
    echo "rute.json actualizado correctamente."
else
    echo "❌ No se encontró el archivo rute.json"
fi

# ---------- MySQL ----------
if pgrep -x "mysqld" > /dev/null; then
    pid=$(pgrep -x "mysqld")
    echo "⚠️ MySQL ya se está ejecutando (PID: $pid)"
else
    echo "🚀 Iniciando MySQL..."
    sudo systemctl start mysqld
    sleep 2
    if pgrep -x "mysqld" > /dev/null; then
        pid=$(pgrep -x "mysqld")
        echo "✅ MySQL iniciado (PID: $pid)"
    else
        echo "❌ Error: No se pudo iniciar MySQL"
    fi
fi
