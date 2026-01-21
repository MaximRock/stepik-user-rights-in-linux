Prepare-server
=========

Подготовка сервера.
Установка необходимых пакетов для проекта и работы сервера(за исключением веб-сервера nginx).
У становка timezone Europe/Moscow.

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. <kbd>defaults/main.yml</kbd>)
Список устанавливаемых пакетов:

```
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

Обновляем пакеты (если требуется более простое обновление замените на <kbd>safe<kbd>)
```
  apt_upgrade: full
```
Кэшируем результат <kbd>apt-get update<kbd>
```
  apt_cache_valid_time: 3600
```

Удаляет неиспользуемые пакеты
```
  apt_autoremove: true
```
Очищает кэш скачанных пакетов
```
  apt_autoclean: true
```
Уставка пакетов (см. <kbd>group_vars/all.yml<kbd>)
```
state: "{{ state.present }}"
```
Устанавливает <kbd>timezone<kbd>
```
  name_timezone: Europe/Moscow
```

Dependencies
------------

Нет

Example Playbook
----------------

```
- name: Update and upgrade apt packages
  ansible.builtin.apt:
    upgrade: "{{ apt_upgrade | default('safe') }}"
    update_cache: "{{ update_package_cache | default(true) }}"
    cache_valid_time: "{{ apt_cache_valid_time | default(3600) }}"
    autoremove: "{{ apt_autoremove | default(true) }}"
    autoclean: "{{ apt_autoclean | default(true) }}"
```


