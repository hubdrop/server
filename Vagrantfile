# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::Config.run do |config|
  # Get attributes from attributes.json
  attributes = JSON.parse(IO.read("attributes.json"))

  # Base Box
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Networking & hostname
  config.vm.network :bridged, :bridge => attributes["vagrant"]["adapter"]
  config.vm.network :hostonly, attributes["vagrant"]["hostonly_ip"]
  config.vm.host_name = attributes["vagrant"]["host_name"]


  # Load and apply a chef recipe
  config.vm.provision :chef_solo do |chef|
    # allow user to specificy cookbooks path
    chef.cookbooks_path = attributes["vagrant"]["cookbooks_path"]

    # Add recipes and attributes:
    chef.add_recipe attributes["run_list"]
    chef.json = attributes
  end

  # Hook up your source code folder to the right places in the VM
  config.vm.share_folder "source", "/source",  attributes["vagrant"]["source_path"]
  config.vm.share_folder "cookbooks", "/var/chef/cookbooks",  attributes["vagrant"]["cookbooks_path"]
end
