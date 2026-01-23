User-roles-config
========

6.root и sudo

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Права доступа.

```yml
  file_permissions:
    root: root
    mode: '0440'
```

Путь к файлу `sshd_config` и `sudoers.d.

```yml
  path_sshd_config: /etc/ssh/sshd_config
  path_sudoersd: /etc/sudoers.d/
```

Список настроек конфигурации `sudoers.d`.

```yml
  file:
    - name: 10-charlie
      content: |
        charlie ALL=(ALL) NOPASSWD: /bin/systemctl restart nginx, /bin/systemctl restart apache2, /bin/systemctl restart mysql
    - name: 20-bob
      content: |
        bob ALL=(ALL) NOPASSWD: /bin/cat /var/log/auth.log, /bin/less /var/log/auth.log, /bin/tail /var/log/auth.log
    - name: 30-alice
      content: |
        alice ALL=(ALL) ALL
    - name: 40-alex
      content: |
        alex ALL=(ALL) NOPASSWD: /usr/bin/vim /etc/nginx/nginx.conf, /usr/bin/nano /etc/nginx/nginx.conf
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
  - name: Disable direct SSH login for root
    ansible.builtin.lineinfile:
      path: "{{ path_sshd_config }}"
      line: 'PermitRootLogin no'
    notify: Restart sshd
```
