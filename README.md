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

Cookbook Deployment
-------------------

To deploy cookbooks to an actual server, you need to, as root user:

1. Install chef-client (which includes chef-solo).
2. Run chef-solo command.


    curl -L https://www.opscode.com/chef/install.sh | sudo bash
    chef-solo -j https://raw.github.com/hubdrop/scripts/master/attributes.json

This should be all you need to go from a brand new Ubuntu Precise server to a fully functional hubdrop.io.
