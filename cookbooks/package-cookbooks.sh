rm chef-solor.tar.gz
tar zcvf chef-solo.tar.gz ../cookbooks --exclude .git --exclude chef-solo.tar.gz
git add chef-solo.tar.gz
git commit -m 'HubDrop: Cookbook Package Updated.'
git push
