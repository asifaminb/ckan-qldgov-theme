Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.network "private_network", ip: "192.168.33.60"
    config.vm.host_name = "ckan.dev"
    config.ssh.forward_agent = true
    config.vm.provision "shell", path: "vagrant/new-provision.sh"
    if Vagrant.has_plugin?("vagrant-proxyconf")
        config.proxy.http     = "http://167.123.1.2:8008"
        config.proxy.https    = "http://167.123.1.2:8008"
        config.proxy.no_proxy = "localhost,127.0.0.1"
    end
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
end
