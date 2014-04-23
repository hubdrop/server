# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Attributes are loaded from attributes.json
  if !(File.exists?("attributes.json"))
    warn "Copy attributes.json.example attributes.json and try again."
    exit
  end

  # Get attributes from attributes.json
  attributes = JSON.parse(IO.read("attributes.json"))

  # Base Box
  config.vm.box = "hashicorp/precise64"

  # Networking & hostname
  config.vm.network :private_network, ip: attributes["vagrant"]["hostonly_ip"]
  config.vm.network :public_network, bridge: attributes["vagrant"]["adapter"]

  config.vm.hostname = attributes["vagrant"]["hostname"]


  # Set Chef as our provisioner
  config.vm.provision :chef_solo do |chef|

    # Cookbooks folder is expected to be in the same folder as this file.
    chef.cookbooks_path = "cookbooks"

    # Add "hubdrop" recipe.
    chef.add_recipe "hubdrop"

    # Pass attributes from json to Chef.
    chef.json = attributes
  end

  # Clone the needed repos
  if !File.directory?("app")
    system('git clone git@github.com:hubdrop/app.git')
    system('git clone git@github.com:hubdrop/cookbooks.git')
  end

  # Make local source code available to the VM
  config.vm.synced_folder "app", "/app",
    owner: 'www-data', group: 'www-data'

  config.vm.synced_folder "cookbooks", "/var/chef/cookbooks"
end
