DEVUDO VAGRANT
==============

This code will help you fire up a devudo devmaster or shopmaster on your local computer.


Getting Started
---------------

1. Install Vagrant
2. Clone this repo.  Init submodules to get cookbooks

    $ git clone git@github.com:devudo/vagrant.git

3. Copy attributes.json.example to attributes.json, modify for your details
  Most important is "adapter".  This must match your local machine's
  active internet connection.  To find out the exact name of your adapter,
  use the command:

    $ VBoxManage list bridgedifs | grep ^Name
    Name:            en0: Wi-Fi (AirPort)

  Enter the entire string into attributes.json at "adapter".
  In the example above the line in attributes.json  would look like:

  "adapter": "en0: Wi-Fi (AirPort)",

4. Enter an IP address for "hostonly_ip". Choose a private IP from a subnet that does not
   conflict with existing subnets or with the IP assisgned to the adapter in step 3. This
   IP is also the value you will use in /etc/hosts to set the hostname. You can use any private
   IP, but "ifconfig" will reveal the subnets virtualbox is already using (an existing virtual machine must be running).

   $ ifconfig

        ...snip...

       vboxnet0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
       inet 192.168.100.100 netmask 0xffffff00 broadcast 192.168.1.255
       ether 0a:00:27:00:00:00

       ...snip...

   Reveals that virtualbox is using the subnet 192.168.100.X

   If no host-only networks are defined yet, you can set up host-only
   networks using Virtualbox's configuration UI, under "preferences/network" on the menubar.
   (The virtualbox manager window must be the foremost window during this configuration,
   not a guest machine wndow).

   Choose a free IP from the host-only subnet:

   In attributes.json:
   "hostonly_ip": "192.168.100.101",

   In /etc/hosts:
   192.168.100.101  devmaster.localhost


5. UP! Create the VM:

    $ vagrant up

6. Make changes to cookbooks/devudo.
7. Reload the VM with the new cookbook

    $ vagrant reload

8. Destroy and rebuild to ensure the new cookbook changes works

    $ vagrant destroy
    $ vagrant up

9. If you want to run an update on the working VM, which is faster than
  vagrant reload or vagrant destroy and up.

  Login to the VM:

    $ vagrant ssh
    vagrant@hostname:~$ sudo chef-solo -j /vagrant/attributes.json

