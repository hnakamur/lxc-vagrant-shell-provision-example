# -*- mode: ruby -*-
# vi: set ft=ruby :

# NOTE:
# You need to run
#   vagrant up && vagrant halt && vagrant up --provision
# instead of just
#   vagrant up
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.101"

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", privileged: false, path: "setup_lxc.sh"
  config.vm.provision "shell", privileged: false, path: "setup_container.sh"
end
