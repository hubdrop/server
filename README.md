DEVUDO VAGRANT
==============

This code will help you fire up a devudo devmaster or shopmaster on your local computer.


Getting Started
---------------

1. Install Vagrant
2. Clone this repo.  Init submodules to get cookbooks
  $ git clone git@github.com:devudo/vagrant.git
  $ git submodule init
  $ git submodule update

3. Copy attributes.json.example to attributes.json, modify for your details
  Most important is "adapter".  This must match your local machine's
  active internet connection.  To find out the exact name of your adapter,
  use the command:
  
  $ VBoxManage list bridgedifs | grep ^Name
  Name:            en0: Wi-Fi (AirPort)
  
  Enter the entire string into attributes.json at "adapter".
  In the example above the line in attributes.json  would look like:
  
  "adapter": "en0: Wi-Fi (AirPort)",

4. UP! Create the VM:
  $ vagrant up
  
5. Make changes to cookbooks/devudo.
6. Reload the VM with the new cookbook
  $ vagrant reload

7. Destroy and rebuild to ensure the new cookbook changes works
  $ vagrant destroy
  $ vagrant up

8. If you want to run an update on the working VM, which is faster than
  vagrant reload or vagrant destroy and up.
  
  Login to the VM:
  $ vagrant ssh
  vagrant@hostname:~$ sudo chef-solo -j /vagrant/attributes.json

