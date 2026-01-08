#!/bin/bash 

# Файл: 8-ssh-config.sh
# Назначение: Настройка SSH
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

. ./set-vars.sh

home_dir=$(pwd)
parent_dir="$(dirname "$home_dir")"
ssh_user_dir="ssh-users"

if [ ${#users[@]} -eq 0 ]; then
    echo "Ошибка: массив users не определен или пуст" >&2
    exit 1
fi

for username in "${users[@]}"; do
    user_dir="$parent_dir/$ssh_user_dir/$username"
    mkdir -p "$user_dir" || {
        echo "Ошибка: не удалось создать директорию $user_dir" >&2
        exit 1
    }

    key_file="$user_dir/$username.key"
    hostname=$(hostname)
    ssh-keygen -q -m PEM \
        -t "$ssh_key_type" \
        -b "$ssh_key_bits" \
        -f "$key_file" \
        -N "" \
        -C "$username$key_comment_suffix-$hostname" || {
            echo "Ошибка: не удалось сгенерировать ключ для пользователя $username" >&2
            exit 1
        }

    chmod 700 "$user_dir"
    chmod 600 "$key_file"
    chmod 644 "$key_file.pub"

    echo "Ключи для пользователя $username созданы в $user_dir"
done

for username in "${users[@]}"; do
    user_dir="$parent_dir/$ssh_user_dir/$username"
    home_ssh_dir_user="/home/$username/.ssh"
    mkdir -p "$home_ssh_dir_user"
    # touch "$home_ssh_dir_user/authorized_keys"
    cat > "$home_ssh_dir_user/authorized_keys" < "$user_dir/$username.key.pub"

    chmod 700 "/home/$username/.ssh"
    chmod 600 "/home/$username/.ssh/authorized_keys"
    chown -R "$username:$username" "/home/$username/.ssh"

    echo "Ключи для пользователя $username скопированы в $home_ssh_dir_user"
done

