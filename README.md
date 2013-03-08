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

4. $ vagrant up

