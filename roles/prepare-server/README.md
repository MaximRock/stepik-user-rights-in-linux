Prepare-server
=========

Подготовка сервера.
Установка необходимых пакетов для проекта и работы сервера (за исключением веб-сервера `nginx`).
У становка `timezone Europe/Moscow`.

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Список устанавливаемых пакетов:

```yml
  base_packages:
    - curl
    - gnupg
    - lsb-release
    - software-properties-common
    - apt-transport-https
    - ca-certificates
    - chrony
    - tzdata
    - needrestart
    - bat
    - acl
    - auditd
    - audispd-plugins
```

Обновляем пакеты (если требуется более простое обновление замените на `safe`):

```yml
  apt_upgrade: full
```

Кэшируем результат `apt-get update`:

```yml
  apt_cache_valid_time: 3600
```

Удаляет неиспользуемые пакеты:

```yml
  apt_autoremove: true
```

Очищает кэш скачанных пакетов:

```yml
  apt_autoclean: true
```

Уставка пакетов (см. `roup_vars/all.yml`):

```yml
state: "{{ state.present }}"
```

Устанавливает `timezone`:

```yml
  name_timezone: Europe/Moscow
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
- name: Update and upgrade apt packages
  ansible.builtin.apt:
    upgrade: "{{ apt_upgrade | default('safe') }}"
    update_cache: "{{ update_package_cache | default(true) }}"
    cache_valid_time: "{{ apt_cache_valid_time | default(3600) }}"
    autoremove: "{{ apt_autoremove | default(true) }}"
    autoclean: "{{ apt_autoclean | default(true) }}"
```
