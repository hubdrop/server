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
We're deploying with chef-solo, which can use a tar.gz to get it's cookbooks.
To update the server, update the tar.gz and push it to GitHub.

    $ cd ~/Repos/hubdrop/cookbooks
    $ tar zcvf chef-solo.tar.gz ../cookbooks
    $ git add chef-solo.tar.gz
    $ git commit -m 'Code Update'
    $ git push
