#!/bin/bash 

# Файл: config-umask.sh
# Назначение: Настройка umask
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

config_profile_d="${config_profile_d:-/etc/profile.d}"
umask_file="$config_profile_d/10-umask-profile.sh"

if [ ! -f "$umask_file" ]; then
    sudo tee "$umask_file" > /dev/null << 'EOF'
# Set default umask for all users
umask 002
EOF
    
    echo "Файл создан: $umask_file"
else
    echo "Файл уже существует: $umask_file"
fi