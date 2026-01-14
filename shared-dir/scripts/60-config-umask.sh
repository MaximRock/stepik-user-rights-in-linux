#!/bin/bash 

# Файл: config-umask.sh
# Назначение: Настройка umask
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

config_profile_d="${config_profile_d:-/etc/profile.d}"
umask_file="$config_profile_d/10-umask-profile.sh"

umask_test_directory="${umask_test_directory:-/umask-test}"
umask_file_test="$umask_test_directory/umask-test-file.test"

umask 027

mkdir -p "$umask_test_directory"
chown -R vagrant:vagrant "$umask_test_directory"

touch "$umask_test_directory/umask-test-file.test"
chown vagrant:vagrant "$umask_test_directory/umask-test-file.test"

echo "$(ls -la $umask_test_directory && umask)"

if [ ! -f "$umask_file" ]; then
    sudo tee "$umask_file" > /dev/null << 'EOF'
# Set default umask for all users
umask 002
EOF
    
    echo "Файл создан: $umask_file"
else
    echo "Файл уже существует: $umask_file"
fi