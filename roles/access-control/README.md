Access-control
=========

3.Групповые и индивидуальные права

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):
Переменные для создания директории `/srv/project`:

```yml
  # /srv/project/
  dir_defaults:
    state: directory
    owner: root
    group: devteam
    file_mode: '0644'
    default_dir_mode: '0775'
```

Список параметров:

- `state`: `directory` - создать директорию
- `owner`: владелец
- `group`: группа
- `file_mode`: права для файла
- `default_dir_mode`: права для директории

Директория проекта `/srv/roject`:

```yml
project_dir: /srv/project/
```

Права доступа в зависимости от файла:

```yml
  directories:
    - path: "{{ project_dir }}"
      mode: '2775'
    - path: "{{ project_dir }}config/"
      mode: '777'
```

Если `true` создаем тестовые файлы.

```yml
create_test_files: true
```

Тестовые файлы:

```yml
create_test_files: true
test_files:
  - path: README.md
    content: |
      # Project Directory
      This directory is for development code.
      Group 'devteam' has read/write access.
      Other teams have read-only or no access.
  - path: main.py
    content: |
      #!/usr/bin/env python3
      print("Hello from project directory!")
  - path: config/config.json
    content: |
      {
        "project": "development",
        "version": "1.0.0"
      }
```

Переменные для директории `/srv/log/`:

```yml
  # /srv/log/
  log_directory:
    path: /srv/log/
    state: directory
    owner: root
    group: ops
    mode: '2770'
```

Групповые права для `/srv/log/`:

```yml
  user_groups:
    qateam: r-x
    devteam: r-x
    ops: rwx
```

Переменные для директории `/tmp/sharedtest`:

```yml
# /tmp/sharedtest/
shared_directory:
  path: /tmp/sharedtest
  state: directory
  owner: root
  group: root
  mode: '1777'
```

Переменные для директории `/srv/log/app1` для установки `sticky bit`:

```yml
# /srv/log/app1/
log_app_directory:
  path: "{{ log_directory.path }}app1/"
  directory: directory
  username: alex
  permissions: rwx
  etype: user
```

Dependencies
------------

Нет

Example Playbook
----------------

- name: Set ACL Sticky bit for directory shared
  ansible.posix.acl:
    path: "{{ log_app_directory.path }}"
    entity: "{{ log_app_directory.username }}"
    etype: "{{ log_app_directory.etype }}"
    permissions: "{{ log_app_directory.permissions }}"
    state: "{{ state.present }}"
