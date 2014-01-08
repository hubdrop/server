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
  config.vm.host_name = attributes["vagrant"]["hostname"]


  # Load and apply a chef recipe
  config.vm.provision :chef_solo do |chef|
    # allow user to specificy cookbooks path
    chef.cookbooks_path = "cookbooks" #attributes["vagrant"]["cookbooks_path"]

    # Add recipes and attributes:
    attributes["run_list"].each do |recipe|
     chef.add_recipe recipe
    end
    chef.json = attributes
  end

  # Hook up your source code folder to the right places in the VM
  config.vm.share_folder "app", "/app",  "web-app"
  config.vm.share_folder "cookbooks", "/var/chef/cookbooks", "cookbooks"
end
