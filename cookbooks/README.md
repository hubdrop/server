HubDrop CookBook
================

HubDrop is more than the app, it is also the server configuration.  To create a hubdrop server, the `hubdrop::default` recipe is used: [hubdrop/recipes/default.rb](hubdrop/recipes/default.rb)

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

Cookbook Installation
---------------------

When installing on a brand new server (without Vagrant) you need to manually install chef:

    curl -L https://www.opscode.com/chef/install.sh | sudo bash

Then, run the first chef-solo command.  See the next section: Cookbook UPdates


Cookbook Updates
----------------

To use chef-solo, we must use remotely available cookbooks.tar.gz and attributes.json files
in order to deploy updates to the server.

Step 1: Package cookbooks
=========================

We're deploying with chef-solo, which can use a tar.gz to get it's cookbooks.
To update the server, update the tar.gz and push it to GitHub.

There is a script you can use to package up the cookbooks and push to github:

    $ cd ~/Repos/hubdrop/cookbooks
    $ sh package-cookbooks.sh

Step 2: Run Chef Solo
=====================

The attributes for the server are be loaded directly from GitHub.
Once the cookbooks tar is pushed and available on GitHub.com remotely, run:

    $  chef-solo -j https://raw.github.com/hubdrop/scripts/master/attributes.json -r https://github.com/hubdrop/cookbooks/raw/master/chef-solo.tar.gz 



