#!/bin/bash 

# Файл: user-roles-config.sh
# Назначение: Настройка прав root и sudo
# Описание: Для charlie добавляем права на управление auditd
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

config_file_sshd="/etc/ssh/sshd_config"
config_sudoers_d="/etc/sudoers.d"

if grep -q "^PermitRootLogin no" "$config_file_sshd"; then
    echo "Настройка PermitRootLogin уже существует"
    sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$config_file_sshd"
else
    echo "Добавляем настройку PermitRootLogin no..."
    echo "PermitRootLogin no" | sudo tee -a "$config_file_sshd"
fi

cat > $config_sudoers_d/10-charlie << 'EOF'
charlie ALL=(ALL) NOPASSWD: /bin/systemctl restart nginx, /bin/systemctl restart apache2, /bin/systemctl restart mysql
# # Права для Charlie (DevOps)
# charlie ALL=(root) NOPASSWD: /bin/systemctl restart auditd
# charlie ALL=(root) NOPASSWD: /usr/bin/auditctl
# charlie ALL=(root) NOPASSWD: /usr/bin/ausearch
# charlie ALL=(root) NOPASSWD: /usr/bin/aureport
EOF

cat > $config_sudoers_d/20-bob << 'EOF'
bob ALL=(ALL) NOPASSWD: /bin/cat /var/log/auth.log, /bin/less /var/log/auth.log, /bin/tail /var/log/auth.log
EOF

cat > $config_sudoers_d/30-alice << 'EOF'
alice ALL=(ALL) ALL
EOF

cat > $config_sudoers_d/40-alex << 'EOF'
alex ALL=(ALL) NOPASSWD: /usr/bin/vim /etc/nginx/nginx.conf, /usr/bin/nano /etc/nginx/nginx.conf
EOF

sshd -t
systemctl restart sshd

chmod 440 $config_sudoers_d/*-*

echo "$(ls -la $config_sudoers_d)"

