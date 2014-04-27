# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Look for project settings file.
  if !(File.exists?("settings.yml"))
    raise NoSettingsException
  end

  # Load the yml files
  require 'yaml'
  settings = YAML.load_file('settings.yml')
  settings.merge!(YAML.load_file('settings.local.yml'))


  # Clone project repo to `./src` if the folder doesn't exist yet, and the setting exists.
  if !(File.directory?("app"))
    system("git clone #{settings['app_repo']} app")
  end

  # Config the VM
  config.vm.box = "hashicorp/precise64"
  config.vm.hostname = settings['server_hostname']

  # Sets IP of the guest machine and allows it to connect to the internet.
  # @TODO: Add the adapter to settings.global.yml. Almost always wlan0
  config.vm.network :private_network, ip:  settings['vansible_ip']
  config.vm.network :public_network, bridge: settings['vansible_adapter']

  # Sync .ssh folder to guest machine.
  config.vm.synced_folder "#{Dir.home}/.ssh", "/home/vagrant/.ssh_host"

  # Read this user's host machine's public ssh key to pass to ansible.
  if !(File.exists?("#{Dir.home}/.ssh/id_rsa.pub"))
     raise NoSshKeyException
  end
  ssh_public_key = IO.read("#{Dir.home}/.ssh/id_rsa.pub").strip!

  # ONLY WORKS if ansible is setup on the HOST machine.
  # See https://github.com/mitchellh/vagrant/issues/2103
  # @TODO: Uncomment once vagrant supports this.
  # config.vm.provision "ansible" do |ansible|
  #   ansible.playbook = settings['vansible_playbook']
  #   ansible.tags = settings['vansible_tags']
  # end

  # Setup ansible and run the playbook.
  # @TODO: Remove once vagrant supports ansible on guest.
  config.vm.provision "shell", path: "tasks/setup-ansible.sh"

  # Run ansible Provisioner via shell.
  config.vm.provision "shell",
    inline: "cd /vagrant; ansible-playbook -c local  -i '#{settings['server_hostname']},' #{settings['vansible_playbook']} --extra-vars 'authorized_keys=\"#{ssh_public_key}\"'"

  # Extra provisioning for vagrant
  config.vm.provision "shell",
    inline: "cd /vagrant; ansible-playbook -c local  -i '#{settings['server_hostname']},' provision.vagrant.yml"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", settings['vansible_memory']]
  end

  # Make local source code available to the VM
  config.vm.synced_folder "app", "/app",
    type: 'nfs'

end

##
# Our Exceptions
#
class NoSettingsException < Vagrant::Errors::VagrantError
  error_message('Project settings file not found. Copy settings.project.example.yml to settings.project.yml, edit to match your project, then try again.')
end

class NoSrcException < Vagrant::Errors::VagrantError
  error_message('Could not create ./src folder. Run as the owner of this folder. ')
end

class NoSshKeyException < Vagrant::Errors::VagrantError
  error_message('An ssh public key could not be found at ~/.ssh/id_rsa.pub. Please generate one and try again.')
end