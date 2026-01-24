#!/bin/bash

# Файл: setup-server-users.sh
# Назначение: Подготовка сервера
# Автор: maximrock
# Дата: 2025-12-27

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS=(
    10-prepare-server.sh
    20-setup-user.sh
    30-access-controll.sh
    40-install-nginx.sh
    50-user-roles-config.sh
    60-config-umask.sh
    70-audit-config.sh
    80-ssh-config.sh
    )
cd "$SCRIPT_DIR" 

echo "=== Запуск подготовки сервера ==="
echo "Работаем в каталоге: $(pwd)"

for script in "${SCRIPTS[@]}"; do
    if [[ ! -f "$script" ]]; then
        echo "Ошибка: файл $script не найден"
        exit 1
    else
        chmod +x "$script"
        echo "Файл $script сделан исполняемым"
    fi

    if [[ ! -x "$script" ]]; then
        chmod +x "$script"
        echo "Файл $script сделан исполняемым"
    else
        echo "Файл $script уже исполняемый"
    fi

done

echo "▶ Шаг 1: Подготовка системы" script 10-prepare-server.sh
echo "--------------------------------------------------------"
bash ./10-prepare-server.sh
echo ""

echo "▶ Шаг 2/3: Настройка пользователей" script 20-setup-user.sh
echo "-----------------------------------------------------------"
bash ./20-setup-user.sh
echo ""

echo "▶ Шаг 3/3: Настройка прав доступа" script 30-access-controll.sh
echo "----------------------------------------------------------------"
bash ./30-access-controll.sh
echo ""

echo "▶ Шаг 4/3: Установка и настройка nginx" script 40-install-nginx.sh
echo "------------------------------------------------------------------"
bash ./40-install-nginx.sh
echo ""

echo "▶ Шаг 5/3: Настройка root и sudo" script 50-user-roles-config.sh
echo "----------------------------------------------------------------"
bash ./50-user-roles-config.sh
echo ""

echo "▶ Шаг 6/3: Настройка umask" script 60-config-umask.sh
echo "-----------------------------------------------------"
bash ./60-config-umask.sh
echo ""

echo "▶ Шаг 7/3: Настройка мониторинга auditd" script 70-audit-config.sh
echo "------------------------------------------------------------------"
bash ./70-audit-config.sh
echo ""

echo "▶ Шаг 8/3: Настройка ssh" script 80-ssh-config.sh
echo "-------------------------------------------------"
bash ./80-ssh-config.sh
echo ""

echo "------------------------------"
echo "Все скрипты выполнены успешно!"

