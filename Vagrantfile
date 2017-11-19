Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.network "private_network", ip: "192.168.33.69"
    config.vm.host_name = "ckanv2.dev"
    config.ssh.forward_agent = true
    config.vm.provision "shell", path: "vagrant/new-provision.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
end
