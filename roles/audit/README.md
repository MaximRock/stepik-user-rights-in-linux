Audit
========

9.Логи и аудит

Requirements
------------

Нет

Role Variables
--------------

Ниже перечислены доступные переменные и их значения по умолчанию (см. `defaults/main.yml`):

Путь к директории `audit`.

```yml
  audit_base_path: /etc/audit/rules.d
```

Права доступа.

```yml
  audit_file_permissions:
    root: root
    mode: '0644'
```

Данные для конфигурационных файлов `rules.d`.

```yml
  audit_config:
    - name: 10-identity.rules
      content: |
        ## Мониторинг файлов паролей и групп ##
        -w /etc/passwd -p wa -k passwd_identity
        -w /etc/shadow -p wa -k shadow_identity
        -w /etc/gshadow -p wa -k gshadow_identity
        -w /etc/group -p wa -k group_identity
        -w /etc/security/opasswd -p wa -k opasswd_identity
    - name: 20-user-mod.rules
      content: |
        ## Мониторинг команд управления пользователями ##
        -w /usr/sbin/useradd -p rwx -k useradd_mod
        -w /usr/sbin/userdel -p x -k userdel_mod
        -w /usr/sbin/usermod -p x -k usermod_mod
        -w /usr/bin/passwd -p x -k passwd_mod
        -w /usr/sbin/groupadd -p x -k groupadd_mod
        -w /usr/sbin/groupdel -p x -k groupdel_mod
        -w /usr/sbin/groupmod -p x -k groupmod_mod
    - name: 30-changes-dir.rules
      content: |
        ## Мониторинг изменений в каталогах ##
        -w /etc/skel/ -p wa -k user_mod
        -w /etc/login.defs -p wa -k login_config
        -w /etc/default/useradd -p wa -k user_config
        -w /srv/logs/ -p wa -k logs_srv
    - name: 40-ssh.rules
      content: |
        ## Мониторинг SSH ключей ##
        -w /etc/ssh/sshd_config -p wa -k ssh_config
        -w /root/.ssh/ -p wa -k ssh_keys
        -w /home/vagrant/.ssh/ -p wa -k ssh_keys
    - name: 50-system-bin.rules
      content: |
        ## Системные бинарники ##
        -w /bin/su -p x -k privileged
        -w /usr/bin/sudo -p x -k privileged
        -w /etc/sudoers -p wa -k privileged
        -w /etc/sudoers.d/ -p wa -k privileged
```

Dependencies
------------

Нет

Example Playbook
----------------

```yml
  - name: Create file audit rules
    ansible.builtin.file:
      path: "{{ audit_base_path }}/{{ item.name }}"
      state: "{{ state.touch }}"
      owner: "{{ audit_file_permissions.root }}"
      group: "{{ audit_file_permissions.root }}"
      mode: "{{ audit_file_permissions.mode }}"
    loop: "{{ audit_config }}"
    loop_control:
      label: "{{ item.name }}"
```
