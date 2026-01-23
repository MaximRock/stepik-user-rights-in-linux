Result
========

Роль для подведения итогов по практическому заданию, состоит из нескольких подролей (см. `tasks/main.yml`).

- check-sum.yml - проверка задания 2.3 копирования файлов из `/etc/skel`;
  (проверка осуществляется сравнением `checksums` файлов у пользователя, у пользователя `alex` удалена строка поэтому проверка не пройдена).
- dir-info.yml - проверка задания 3.3 `SGID /srv/pject/`
- acl-mask.yml - проверка задания 4.3 `маска (mask) не обрезает нужные биты`.
- audit-check.yml - проверка задания 9.3 работа `audit`.

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Данные для файлов в директории `/etc/skel`.

```yml
  result_skel_files:
    - .bashrc
    - .bash_logout
    - .profile
```

Пути к файлам.

```yml
  result_project_dir: /srv/project/

  result_log_app_dir: /srv/log/app1/
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
  - name: Checksum directory /etc/skel
    ansible.builtin.include_tasks: check-sum.yml
    tags: check-sum

  - name: Info directory /srv/project
    ansible.builtin.include_tasks: dir-info.yml
    tags: dir-info

  - name: Info ACL mask directory /srv/logs/app1/
    ansible.builtin.include_tasks: acl-mask.yml
    tags: acl-mask

  - name: Info auditreport
    ansible.builtin.include_tasks: audit-check.yml
    tags: audit-check
```
