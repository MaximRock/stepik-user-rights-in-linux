# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"
    config.vm.box_check_update = false

    run_bash = ENV['RUN_BASH'] == 'true'
    run_ansible = ENV['RUN_ANSIBLE'] == 'true'

    config.vm.define "node" do |node|
        node.vm.hostname = "stepik"
        node.vm.network "private_network", ip: "38.0.0.10", hostname: true, bridge: "enp7s0"
        node.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
        config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
        node.vm.synced_folder "shared-dir", "/home/vagrant/shared-dir/"
        node.vm.provider "virtualbox" do |vb|
            vb.gui = false
            vb.memory = "2048"
            vb.cpus = 2
            vb.name = "stepik"
        end
    end

    if run_ansible
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "play.yml"
            ansible.tags = ENV['ANSIBLE_TAGS'].split(',')
        end
    end

    if run_bash
        config.vm.provision "shell", privileged: true, inline: <<-SHELL
            cd /home/vagrant/shared-dir/scripts && bash ./main.sh
        SHELL
    end
end
