SSH
========

Эту роль частично можно отнести к заданию `8. Автоматизация массового онбординга`.

Роль создает `ssh` ключи и директории `/home/user/.ssh/`.

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Данные для директории.

```yml
  ssh_users: ssh-users # имя директории
  ssh_base_path: "{{ playbook_dir }}/{{ ssh_users }}" # путь к директории в которой будут сгенерированы ключи
```

Права доступа.

```yml
  ssh_file_permissions:
    root: root
    mode_dir: '2775'
```

Данные для ключей.

```yml
  ssh_key:
    type: ed25519
    size: '4096'
    prefix: '@srv'
```

Коллекции `ansible`.

```yml
  ssh_collections:
    - community.crypto
    - ansible.posix
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
- name: Create main ssh users directory
  ansible.builtin.file:
    path: "{{ ssh_base_path }}"
    state: "{{ state.directory }}"
    owner: "{{ ssh_current_user.stdout }}"
    group: "{{ ssh_current_user.stdout }}"
    mode: "{{ ssh_file_permissions.mode_dir }}"
  become_user: "{{ ssh_current_user.stdout }}"
  become: false
  delegate_to: localhost
  run_once: true
```
