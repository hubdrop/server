#!/usr/bin/env bash
# @TODO: This will all be removed once vagrant supports ansible provisioning.
if [ ! `which ansible` ]; then
    apt-get install python-software-properties -y
    add-apt-repository ppa:rquillo/ansible -y
    apt-get update
    apt-get install ansible -y
fi
