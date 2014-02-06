#!/bin/bash
git clone git@github.com:hubdrop/cookbooks.git
git clone git@github.com:hubdrop/app.git

# @TODO: Let's make init.sh a wizard, and ask these things
cp attributes.json.example attributes.json
echo '10.10.10.10  hubdrop.local' | sudo tee -a /etc/hosts

export SYMFONY__APP__URL='http://hubdrop.local'
export SYMFONY__APP__GITHUB__USERNAME='hubdrop-user'
export SYMFONY__APP__GITHUB__ORGANIZATION='drupalprojects'
export SYMFONY__APP__GITHUB__AUTHORIZATION='4a8c4d54758db858bc912169f3e51fafd1fff5f9'
export SYMFONY__APP__DRUPAL__USERNAME='jon pugh'
