# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::Config.run do |config|
  
  # LOCAL OPTIONS
  # Edit these, as needed
  local_config = {}
  local_config[:email] = "jon@thinkdrop.net"
  local_config[:hostname] = "devmaster.localhost"
  local_config[:adapter] = "eth0" # wlan0 for wireless, eth0 for wired.
  local_config[:recipe] = "devudo::aegir-devmaster"
  local_config[:root_password] = "abcdefg"
  local_config[:host_repos_path] = "/home/jon/Repos"
  
  # DEVUDO CONFIG
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  # Networking & hostname  
  config.vm.network :bridged, :bridge => local_config[:adapter]
  config.vm.host_name = local_config[:hostname] 

  # Load and apply a chef recipe
  config.vm.provision :chef_solo do |chef|
    # Add recipes and attributes:
    chef.add_recipe local_config[:recipe]
    chef.json = {:aegir => {}, :mysql => {}}
    chef.json[:aegir][:client_email] = local_config[:email]
    chef.json[:mysql][:server_root_password] = local_config[:root_password]
    chef.json[:mysql][:server_debian_password] = local_config[:root_password]
    chef.json[:mysql][:server_repl_password] = local_config[:root_password]
  end
  
  # Hook up your source code folder to the right places in the VM
  config.vm.share_folder "source", "/source",  local_config[:host_repos_path]

end