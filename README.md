HubDrop Vagrant
===============

This code will help you fire up a hubdrop server with vagrant.

Setup
-----
Follow the instructions at https://github.com/hubdrop/development to get HubDrop Vagrant up and running.

After cloning this repo, run `init.sh`.

Additional Repos
----------------
`init.sh` clones the repos for `hubdrop/app` and `hubdrop/cookbooks` to this folder.  These folders are added as vagrant shared folders. 

Edit the source code in these folders to develop hubdrop.  The files are available inside the VM.


Configuring your Network Adapter
--------------------------------

The attributes.json is used to determine the network adapter your virtual machine uses to connect to the internet.

If your adapter is not `eth0` you must edit attributes.json.

You can call the following command to determine your adapter's name.

    $ VBoxManage list bridgedifs | grep ^Name
    Name:            en0: Wi-Fi (AirPort)

  Enter the entire string into attributes.json at "adapter".
  In the example above the line in attributes.json  would look like:

  "adapter": "en0: Wi-Fi (AirPort)",

Configuring your IP
-------------------

If, for some reason, another device on your network uses the IP 10.10.10.10, you can change it in attributes.json.

9. If you want to run an update on the working VM, which is faster than
  vagrant reload or vagrant destroy and up.

  Login to the VM:

    $ vagrant ssh
    vagrant@hostname:~$ sudo chef-solo -j /vagrant/attributes.json

