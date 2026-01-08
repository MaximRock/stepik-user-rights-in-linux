#!/bin/bash 

# Файл: install-nginx.sh
# Назначение: Установка и базовая настройка nginx
# Автор: maximrock
# Дата: $(date +%Y-%m-%d)

set -e

apt install nginx -y > /dev/null 2>&1

mkdir -p /srv/www/site1.local/{public_html,logs,tmp}
touch /srv/www/site1.local/logs/install.log

# groupadd --system nginx
# useradd --system --shell /usr/sbin/nologin --gid nginx nginx
chown -R www-data:www-data /srv/www/
find /srv/www/ -type d -exec chmod 755 {} \;
find /srv/www/ -type f -exec chmod 644 {} \;

cat > /srv/www/site1.local/public_html/index.html << 'EOF'
<h1>Site 1 работает!</h1><p>Добро пожаловать на site1.local</p>
EOF

cat > /etc/nginx/sites-available/site1.local.conf << 'EOF'
server {
    listen 80;
    listen [::]:80;
    
    server_name site1.local www.site1.local;
    root /srv/www/site1.local/public_html;
    index index.html index.htm;
    
    access_log /srv/www/site1.local/logs/site1_access.log;
    error_log /srv/www/site1.local/logs/site1_error.log;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # Пример дополнительных настроек
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 365d;
    }
}
EOF

if [ ! -f /etc/nginx/sites-enabled/site1.local.conf ]; then
    ln -s /etc/nginx/sites-available/site1.local.conf /etc/nginx/sites-enabled/
fi


# ln -s /etc/nginx/sites-available/site1.local.conf /etc/nginx/sites-enabled/

echo "$(nginx -t)"
systemctl restart nginx

output=$(sudo -u www-data sh -c 'curl -sS -H "Host: site1.local" http://localhost:80')
echo "$output"

sudo -u www-data sh -c "echo '$(date +"%Y-%m-%d %H:%M:%S") Установка nginx завершена' >> /srv/www/site1.local/logs/install.log"
echo "$(tail -n 3 /srv/www/site1.local/logs/install.log)"
