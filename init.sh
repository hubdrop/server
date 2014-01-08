#!/bin/bash
git clone git@github.com:hubdrop/cookbooks.git
git clone git@github.com:hubdrop/app.git

# @TODO: Let's make init.sh a wizard, and ask these things
cp attributes.json.example attributes.json
echo '1.1.1.1  hubdrop.local' | sudo tee -a /etc/hosts
