Config-nginx
=========

5.Сервисные аккаунты и безопасность.

Установка и начальная настройка `nginx`.
При установке `nginx` системный пользователь создается автоматически под именем `www-data`.

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Имя пакета.

```yml
  package_name: nginx
```

Директория для веб. сайта.

```yml
  base_path: /srv/www/
```

Данные для группы и пользователя.

```yml
  web_user:
    www_data: www-data
    root: root

  web_group:
    www_data: www-data
    root: root
```

Права доступа.

```yml
  mode:
    directory: '2775'
    file: '0644'
    mode_link: '0777'
```

Директории для сайта.

```yml
  website:
    name: site1.local
    directories:
      - public_html
      - logs
      - tmp
      - cache
```

Файл `index.html`.

```yml
  index_file: index.html
```

Основной путь до сайта `/srv/www/site1.local`.
Путь до файла `index.html`.

```yml
  websit_base_path: "{{ base_path }}{{ website.name }}"
  path_file_index_html: "{{ websit_base_path }}/{{ website.directories[0] }}/{{ index_file }}"
```

Путь к конфигурационному файлу сайта.

```yml
  path_config_site: "/etc/nginx/sites-available/{{ website.name }}.conf"
  path_link_config_site: "/etc/nginx/sites-enabled/"
```

Путь до `log_directory`.

```yml
  log_directory:
    log_base_path: "{{ websit_base_path }}/{{ website.directories[1] }}"
    log_files_name:
      - install.log
      - site1_access.log
      - site1_error.log
```

Переменные используемые в конфигурационном файле для сайта(см. `templates/nginx.config.j2.`).

```yml
nginx_config:
  root:
    path_root: "{{ websit_base_path }}/{{ website.directories[0] }}"
  index:
    - index.html
    - index.htm
  path_access_log: "{{ log_directory.log_base_path }}/{{ log_directory.log_files_name[1] }}"
  path_error_log: "{{ log_directory.log_base_path }}/{{ log_directory.log_files_name[2] }}"
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
- name: Install nginx
  ansible.builtin.apt:
    name: "{{ package_name | default('nginx') }}"
    state: "{{ state.present }}"
    update_cache: "{{ update_package_cache | bool }}"
```
