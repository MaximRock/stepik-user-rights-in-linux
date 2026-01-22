Users-and-groups
=========

Выполнение пункта 2 задания.
Создание пользователей и групп.

> ## Важно
> При перезапуске роли пользователи и группы создаются заново!

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

```yml
  user_groups:
    - devteam
    - qateam
    - ops
```

Список имен групп.

```yml
  state: "{{ state.present }}"
```

Создание пользователей и групп (см. `group_vars/all.yml`).

```yml
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

- `username:` имя пользователя
- `group:` имя группы
- `shell:` терминал
- `create_home:` домашняя директория
- `first_login_change:` если `true` устанавливаем пользователя

Политика истечения паролей.

```yml
  password_policy:
    max_days: 90
    min_days: 1
    warn_days: 7
    inactive_days: 30
```

Список параметров пароля:

- `max_days:` максимальное количество дней между сменой пароля
- `min_days:` минимальное количество дней между сменами парол
- `warn_days:` за сколько дней предупреждать об истечении пароля
- `inactive_days:` сколько дней после истечения пароля отключать аккаунт

```yml
  temp_password: 'Temp123'
```

Временный пароль для пользователей

Dependencies
------------

Нет

Example Playbook
----------------

```yml
  - name: Create groups
    ansible.builtin.group:
      name: "{{ item }}"
      state: "{{ state.present }}"
    loop: "{{ user_groups }}"
    loop_control:
      label: "{{ item }}"
    register: grp
```
