HubDrop Vagrant
===============

This project is used to develop HubDrop.  You need Vagrant 1.5 or later.

This project now uses Ansible for radically simple provisioning.

Setup
-----

Everything is now built into the Vagrantfile.  To get an instance of hubdrop running,
simply:

1. Clone this repo and change directory:

  ```
  $ git clone git@github.com:hubdrop/vagrant.git
  $ cd vagrant
  ```

2. Vagrant up:

  ```
  $ vagrant up
  ```
  Then, you should be able to visit [http://hubdrop.local](http://hubdrop.local) 

The Vagrantfile will clone the hubdrop app source for you and provision a vagrant server.

Vagrant will handle saving a hosts file record so when you are done with `vagrant up` simply visit and you should see the website.