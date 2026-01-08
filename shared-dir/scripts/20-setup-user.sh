#!/bin/bash 

# Файл: setup-server-users.sh
# Назначение: Создание пользователей и групп на сервере
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

. ./set-vars.sh

# users=(alice bob alex charlie)
# user_groups=(devteam qateam ops)
# group_file="/etc/group"
# user_file="/etc/passwd"

export users

check_and_create() {
    local target_file=$1
    local create_cmd=$2
    shift 2
    
    for item in "$@"; do
        echo "Проверяю: $item"
        if grep -q "^$item:" "$target_file"; then
            echo "'$item' уже существует"
        else
            echo "'$item' не найден, выполняю: $create_cmd $item"
            $create_cmd "$item"
        fi
    done
}

check_and_create "$group_file" "groupadd" "${user_groups[@]}"

for i in "${users[@]}"; do
    if grep -q "$i" /etc/passwd; then
        echo "user - '$i' exists"
    else
        echo "create user - '$i'"
        useradd "$i" -m -s /bin/bash
        echo "$i:Temp123" | chpasswd
    fi
done

for i in "${users[@]}"; do
    if [[ "$i" == "alice" || "$i" == "alex" ]]; then
        usermod -aG "${user_groups[0]}" "$i" 
        groups "$i"
    elif [[ "$i" == "bob" ]]; then
        usermod -aG "${user_groups[1]}" "$i" 
        groups "$i"
    else
        usermod -aG "${user_groups[2]}" "$i" 
        groups "$i"
    fi
done

for user in "${users[@]}"; do
    chage -M 90 -W 7 -d 0 "$user" 
    chage -l "$user" &> /dev/null
done









