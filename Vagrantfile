# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::Config.run do |config|
  # Get attributes from attributes.json
  local = JSON.parse(IO.read("attributes.json"))
  
  # Base Box
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  # Networking & hostname  
  config.vm.network :bridged, :bridge => local["vagrant"]["adapter"]
  config.vm.host_name = local["vagrant"]["host_name"]

  # Load and apply a chef recipe
  config.vm.provision :chef_solo do |chef|
    # Add recipes and attributes:
    chef.add_recipe local["vagrant"]["recipe"]
    chef.json = {:aegir => {}, :mysql => {}}
    chef.json[:aegir][:client_email] = local["aegir"]["client_email"]
    chef.json[:mysql][:server_root_password] = local["mysql"]["server_root_password"]
    chef.json[:mysql][:server_debian_password] = local["mysql"]["server_root_password"]
    chef.json[:mysql][:server_repl_password] = local["mysql"]["server_root_password"]
  end
  
  # Hook up your source code folder to the right places in the VM
  config.vm.share_folder "source", "/source",  local["vagrant"]["source_path"]

end