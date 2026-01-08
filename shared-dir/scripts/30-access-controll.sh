#!/bin/bash 

# Файл: setup-server-users.sh
# Назначение: Групповые и индивидуальные права
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

. ./set-vars.sh

# source ./10-prepare-server.sh &> /dev/null

# base_dir="$base_dir"
# path_project="$base_dir/$dir_project"
# path_logs="$base_dir/$dir_logs"
# path_app1="$path_logs/$dir_app1"
# share_dir="$share_dir"



if [ -d "$path_project" ]; then
    echo "$path_project - настраиваем"
    echo "=============================="
    chown -R root:devteam "$path_project"
    chmod 2775 "$path_project"
    echo "Директория создана с правами:"
    ls -ld "$path_project"
    
else
    echo "$path_project - не существует"
fi

if [ -d "$path_logs" ]; then
    echo "$path_logs - настраиваем"
    echo "=============================="
    chown -R root:ops "$path_logs"
    chmod 770 "$path_logs"
    setfacl -m g:qateam:rx "$path_logs"
    setfacl -m g:devteam:rx "$path_logs"
    setfacl -m d:g:devteam:rx "$path_logs"
    setfacl -m d:g:qateam:rx "$path_logs"
    setfacl -m d:g:ops:rwx "$path_logs"
    echo "Директория создана с правами:"
    ls -ld "$path_logs"
    #getfacl "$path_logs"
else
    echo "$if [ -d "$path_logs" ]; then
 - не существует"
fi

if [ -d "$share_dir" ]; then
    echo "$share_dir - настраиваем"
    echo "=============================="
    chmod 1777 "$share_dir"
    echo "Директория $share_dir настроена со Sticky bit:"
    ls -ld "$share_dir"
else
    echo "$share_dir - не существует"
fi

if [ -d "$path_app1" ]; then
    echo "$path_app1 - настраиваем"
    echo "========================"
    setfacl -m u:alex:rwx "$path_app1"
else
    echo "$path_app1 - не существует"
fi























