#!/bin/bash 

# Файл: 70-audit-config.sh
# Назначение: Установка, настройка и запуск auditd
# Описание: Отступление от задания, создал группу audit-admins
#           и добавил Charlie в эту группу для мониторинга логов.
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)


config_auditd="/etc/audit/rules.d"

apt install auditd audispd-plugins -y &> /dev/null

# # 1. Создаем специальную группу для администраторов audit
# groupadd audit-admins

# # 2. Добавляем Charlie в эту группу
# usermod -aG audit-admins charlie

# # 3. Меняем владельца каталога с правилами
# chown -R root:audit-admins /etc/audit/rules.d/

# # 4. Даем права на чтение и запись группе
# chmod -R 770 /etc/audit/rules.d/

# # 5. Включаем setgid bit (новые файлы будут наследовать группу)
# chmod g+s /etc/audit/rules.d/

# # 6. Проверяем
# ls -lad /etc/audit/rules.d/

cat > $config_auditd/10-identity.rules << 'EOF'
## Мониторинг файлов паролей и групп ##
-w /etc/passwd -p wa -k passwd_identity
-w /etc/shadow -p wa -k shadow_identity
-w /etc/gshadow -p wa -k gshadow_identity
-w /etc/group -p wa -k group_identity
-w /etc/security/opasswd -p wa -k opasswd_identity
EOF

cat > $config_auditd/20-user-mod.rules << 'EOF'
## Мониторинг команд управления пользователями ##
-w /usr/sbin/useradd -p rwx -k useradd_mod
-w /usr/sbin/userdel -p x -k userdel_mod
-w /usr/sbin/usermod -p x -k usermod_mod
-w /usr/bin/passwd -p x -k passwd_mod
-w /usr/sbin/groupadd -p x -k groupadd_mod
-w /usr/sbin/groupdel -p x -k groupdel_mod
-w /usr/sbin/groupmod -p x -k groupmod_mod
EOF

cat > $config_auditd/30-changes-dir.rules << 'EOF'
## Мониторинг изменений в каталогах ##
-w /etc/skel/ -p wa -k user_mod
-w /etc/login.defs -p wa -k login_config
-w /etc/default/useradd -p wa -k user_config
-w /srv/logs/ -p wa -k logs_srv
EOF

cat > $config_auditd/40-ssh.rules << 'EOF'
## Мониторинг SSH ключей ##
-w /etc/ssh/sshd_config -p wa -k ssh_config
-w /root/.ssh/ -p wa -k ssh_keys
-w /home/*/.ssh/ -p wa -k ssh_keys
EOF

cat > $config_auditd/50-system-bin.rules << 'EOF'
## Системные бинарники ##
-w /bin/su -p x -k privileged
-w /usr/bin/sudo -p x -k privileged
-w /etc/sudoers -p wa -k privileged
-w /etc/sudoers.d/ -p wa -k privileged
EOF

augenrules --load &> /dev/null

systemctl enable auditd
systemctl start auditd

# echo "Проверка статуса auditd:"
# systemctl status auditd --no-pager

echo "Активные правила аудита:"
auditctl -l