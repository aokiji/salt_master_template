# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.4"

  config.vm.define :master do |master|
    master.vm.network "public_network", ip: "192.168.33.91"
    master.vm.hostname = 'master'

    master.vm.synced_folder "salt/roots/", "/srv/"

    master.vm.provision :salt do |salt|
      salt.install_master = true
      salt.no_minion = true
      salt.master_config = "salt/master"
      salt.master_key = "salt/keys/master.pem"
      salt.master_pub = "salt/keys/master.pub"
      salt.run_highstate = false
      salt.seed_master =
        {
          minion1: "salt/keys/minion1.pub",
          minion2: "salt/keys/minion2.pub"
        }
      salt.run_highstate = true
    end
  end
end
