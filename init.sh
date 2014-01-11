#!/bin/bash
git submodule init
git submodule update

# @TODO: Let's make init.sh a wizard, and ask these things
if [ ! -f /tmp/foo.txt ]; then
  cp attributes.json.example attributes.json
fi

# @TODO: Only add to hosts if it isn't there already.
echo '10.10.10.10  hubdrop.local' | sudo tee -a /etc/hosts
