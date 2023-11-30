Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  config.vm.provider "virtualbox" do |vb|
   vb.memory = "1024"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
    sudo dpkg -i puppet6-release-bionic.deb
    sudo apt-get update
    sudo apt-get install -y puppet-agent
  SHELL

  config.vm.provision "puppet" do |puppet|       
    puppet.manifests_path = "manifests"   
    puppet.manifest_file = "init.pp"   
  end

end