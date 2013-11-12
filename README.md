HubDrop CookBook
================


Cookbook Development
--------------------

To develop these cookbooks you need:

**knife**

Install with:

    $ sudo apt-get install chef

**This Repo**

1. Cloned to ~/Repos/hubdrop/cookbooks (or your preferred folder.)
2. Symlink from /var/chef/cookbooks -> ~/Repos/hubdrop/cookbooks

**Community Cookbooks**

Whenever possible, we should use the community cookbooks.
To add other cookbooks, you can now use knife to install community cookbooks:

    $ knife cookbook site download php
    $ knife cookbook site install php


Cookbook Updates 
----------------
We're deploying with chef-solo, which can use a tar.gz to get it's cookbooks.
To update the server, update the tar.gz and push it to GitHub.

    $ cd ~/Repos/hubdrop/cookbooks
    $ tar zcvf chef-solo.tar.gz ../cookbooks
    $ git add chef-solo.tar.gz
    $ git commit -m 'Code Update'
    $ git push

Cookbook Installation
---------------------

When installing on a brand new server (without Vagrant) you need to manually install chef:

    curl -L https://www.opscode.com/chef/install.sh | sudo bash

Then, run the first chef-solo command.  See the next section: Cookbook UPdates


Cookbook Updates
----------------

To use chef-solo, we must use remotely available cookbooks. tar.gz and attributes.json files.

Step 1: Package cookbooks
=========================

We're deploying with chef-solo, which can use a tar.gz to get it's cookbooks.
To update the server, update the tar.gz and push it to GitHub.

    $ cd ~/Repos/hubdrop/cookbooks
    $ tar zcvf chef-solo.tar.gz ../cookbooks
    $ git add chef-solo.tar.gz
    $ git commit -m 'Code Update'
    $ git push

@TODO: Write a short bash script for this.


Step 2: Run Chef Solo
=====================

The attributes for the server are be loaded directly from GitHub.
Once the cookbooks tar is pushed and available on GitHub.com remotely, run:

    $ chef-solo -j https://raw.github.com/hubdrop/scripts/master/attributes.json



