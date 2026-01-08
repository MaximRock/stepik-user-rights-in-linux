#!/bin/bash 

# Файл: setup-server-users.sh
# Назначение: Подготовка сервера
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

. ./set-vars.sh

# base_dir="/srv"
# dir_project="project"
# dir_logs="logs"
# dir_app1="app1"
# share_dir="/tmp/sharedtest/"

apt update > /dev/null 2>&1 #&& apt upgrade -y > /dev/null 2>&1
apt install acl  -y > /dev/null 2>&1

echo "создаем директории"
mkdir -p "$base_dir"/{"$dir_project","$dir_logs"/"$dir_app1"}
mkdir -p "$share_dir"

echo ""
echo "Содержимое $base_dir:"
ls -la "$base_dir"
