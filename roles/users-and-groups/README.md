Users-and-groups
=========

Выполнение пункта 2 задания.
Создание пользователей и групп.

>### Важно
> При перезапуске роли пользователи и группы создаются заново!

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. <kbd>defaults/main.yml<kbd>):

```
  user_groups:
    - devteam
    - qateam
    - ops
```

Список имен групп.
```
  state: "{{ state.present }}"
```

Создание пользователей и групп (см. <kbd>group_vars/all.yml<kbd>)

```
  users:
    - username: alex
      group: devteam
      shell: /bin/bash
      create_home: true
      first_login_change: true
    - username: alice
      group: devteam
      shell: /bin/bash
      create_home: true
      first_login_change: true
    - username: bob
      group: qateam
      shell: /bin/bash
      create_home: true
      first_login_change: true
    - username: charlie
      group: ops
      shell: /bin/bash
      create_home: true
      first_login_change: true
```

Список пользователей с параметрами:

- <kbd>username:<kbd> имя пользователя
- <kbd>group:<kbd> имя группы
- <kbd>shell:<kbd> терминал
- <kbd>create_home:<kbd> домашняя директория
- <kbd>first_login_change:<kbd> если true устанавливаем пользователя

```
  password_policy:
    max_days: 90
    min_days: 1
    warn_days: 7
    inactive_days: 30
```

Список параметров пароля:

- <kbd>max_days:<kbd> максимальное количество дней между сменой пароля
- <kbd>min_days:<kbd> минимальное количество дней между сменами парол
- <kbd>warn_days:<kbd> за сколько дней предупреждать об истечении пароля
- <kbd>inactive_days:<kbd> сколько дней после истечения пароля отключать аккаунт

```
  temp_password: 'Temp123'
```

Временный пароль для пользователей

Dependencies
------------

Нет

Example Playbook
----------------

```
  - name: Create groups
    ansible.builtin.group:
      name: "{{ item }}"
      state: "{{ state.present }}"
    loop: "{{ user_groups }}"
    loop_control:
      label: "{{ item }}"
    register: grp
```
