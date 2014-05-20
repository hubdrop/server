HubDrop Server
===============

This project is used to develop & deploy HubDrop.  You want Vagrant 1.6 or later.

This project now uses Ansible for radically simple provisioning.

Local Development Setup
-----------------------

Everything is now built into the Vagrantfile.  To get an instance of hubdrop running,
simply:

1. Clone this repo and change directory:

  ```
  $ git clone git@github.com:hubdrop/server.git HubDrop
  $ cd HubDrop
  ```

2. Vagrant up:

  ```
  $ vagrant up
  ```
  Then, you should be able to visit [http://hubdrop.local](http://hubdrop.local) 

The Vagrantfile will clone the hubdrop app source for you and provision a vagrant server.

Vagrant will handle saving a hosts file record so when you are done with `vagrant up` simply visit and you should see the website.

Server Deployment
-----------------

Vagrant can be used to provision servers on digitalocean.com.

To launch a hubdrop server on digitalocean.com, first install the vagrant plugin:

```
vagrant plugin install vagrant-digitalocean
```

Then change to the `digitalocean` directory

```
$ cd digitalocean
$ vagrant
```

The first time you call "vagrant", it will create an empty file located at  `./digitalocean/.vagrant/digitalocean.yml`.

Edit this file with your Digital Ocean Client ID and API key.

After that, you can simply call `vagrant up --provider=digital_ocean` to create a new droplet!

```
$ vagrant up --provider=digital_ocean
Bringing machine 'default' up with 'digital_ocean' provider...
==> default: Using existing SSH key: Vagrant
==> default: Creating a new droplet...
==> default: Assigned IP address: 0.0.0.0
==> default: Rsyncing folder: /home/jon/Projects/Hubdrop/Server/ => /vagrant...
==> default: Checking for host entries
==> default: Running provisioner: ansible...
```

One provisioned, you can do everything you can with a virtual server:

`vagrant ssh` will ssh you into the server.
`vagrant destroy` will destroy the droplet.
`vagrant provision` will re-run the ansible playbook.