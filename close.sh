#!/bin/bash

echo "🛑 Deteniendo servicios..."

# ---------- Expo ----------
if pgrep -f "pnpm run web" > /dev/null; then
    pid=$(pgrep -f "pnpm run web")
    kill $pid
    echo "✅ Expo detenido (PID: $pid)"
else
    echo "ℹ️ Expo no estaba corriendo"
fi

# ---------- PHP ----------
if lsof -i :8000 | grep LISTEN > /dev/null; then
    pid=$(lsof -ti :8000)
    kill $pid
    echo "✅ PHP detenido (PID: $pid)"
else
    echo "ℹ️ PHP no estaba corriendo"
fi

# ---------- MySQL ----------
if pgrep -x "mysqld" > /dev/null; then
    echo "🚫 Deteniendo MySQL..."
    sudo systemctl stop mysql
    echo "✅ MySQL detenido"
else
    echo "ℹ️ MySQL no estaba corriendo"
fi
