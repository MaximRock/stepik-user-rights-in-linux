#!/bin/bash

# Настройки директорий сервера и общего раздела
# script 10-prepare-server.sh
base_dir="/srv"
dir_project="project"
dir_logs="logs"
dir_app1="app1"
share_dir="/tmp/sharedtest/"

# Настройки пользователей
# script 20-setup-user.sh
users=(alice bob alex charlie)
user_groups=(devteam qateam ops)
group_file="/etc/group"
user_file="/etc/passwd"

# Настройки директорий проекта
# script 30-access-controll.sh
base_dir="$base_dir"
path_project="$base_dir/$dir_project"
path_logs="$base_dir/$dir_logs"
path_app1="$path_logs/$dir_app1"
share_dir="$share_dir"

# Настройки SSH ключей
# script 80-ssh-config.sh
ssh_key_type="ed25519"
ssh_key_bits=4096
key_comment_suffix="@srv"