Umask
========

7.umask и создание файлов

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Путь к директории `/etc/profile.d/`.

```yml
  umask_path_profiled: /etc/profile.d
```

Права доступа.

```yml
  umask_file_permissions:
    root: root
    vagrant: vagrant
    mode: '0644'
```

Данные для конфигурционного файла.

```yml
  umask_file:
    name: 10-umask-profile.sh
    content: |
      umask 027
```

Данные для тестового файла, проверки работы `umask`.

```yml
  umask_path_test: /umask-test
  umask_test_file:
    name: umask-test
    mode: '0775'
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
  - name: Create test directory
    ansible.builtin.shell: |
      mkdir "{{ umask_path_test }}"
      chown -R "{{ umask_file_permissions.vagrant }}":"{{ umask_file_permissions.vagrant }}" "{{ umask_path_test }}"
      umask 027
      touch "{{ umask_path_test }}/{{ umask_test_file.name }}"
      ls -la "{{ umask_path_test }}/{{ umask_test_file.name }}"
    register: umask_result
    changed_when: true
```
