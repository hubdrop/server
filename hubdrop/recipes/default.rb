
# Include Recipes
include_recipe "apt"
include_recipe "apache2::mod_php5"
include_recipe "php::module_curl"

# Extra packages
package "git"
package "vim"

# Create the hubdrop user
user "hubdrop" do
  comment "HubDrop"
  home "/var/hubdrop"
  shell "/bin/bash"
  system true
end
# Add hubdrop to www-data group
group "www-data" do
  action :modify
  members "hubdrop"
  append true
end
# Add www-data to hubdrop group
group "hubdrop" do
  action :modify
  members "www-data"
  append true
end
directory "/var/hubdrop" do
  owner "hubdrop"
  group "hubdrop"
  mode 00755
  action :create
  recursive true
end
directory "/var/hubdrop/repos" do
  owner "hubdrop"
  group "hubdrop"
  mode 00775
  action :create
  recursive true
end
directory "/var/hubdrop/.drush" do
  owner "hubdrop"
  group "hubdrop"
  mode 00755
  action :create
  recursive true
end
directory "/var/hubdrop/.ssh" do
  owner "hubdrop"
  group "hubdrop"
  mode 00755
  action :create
  recursive true
end

# Install Jenkins server
# include_recipe "jenkins::server"

# Deploy hubdrop Symfony app
# @TODO: Write hubdrop Symfony app

# Deploy hubdrop server scripts
# @TODO: Learn and use deploy LWRP

#
#
# WEB APP
#
#
git "/var/hubdrop/app" do
  repository "https://github.com/hubdrop/web-app.git"
  reference "master"
  action :sync
  user "hubdrop"
  group "hubdrop"
  #notifies :run, "bash[compile_app_name]"
end

# Group can execute app.php
file "/var/hubdrop/app/web/app.php" do
  mode "654"
  action :touch
end
execute "chmod 775 /var/hubdrop/app/app/cache"
execute "chmod 775 /var/hubdrop/app/app/logs"
execute "chown hubdrop:hubdrop /var/hubdrop/app/app/cache"
execute "chown hubdrop:hubdrop /var/hubdrop/app/app/logs"

web_app "hubdrop" do
  server_name node['hostname']
  server_aliases [node['vagrant']['hostname'], 'hubdrop.io']
  docroot "/var/hubdrop/app/web"
  allow_override "All"
  #docroot "/var/www"
end

# @TODO: Learn and use deploy LWRP
#deploy "/var/web-app" do
#  repo "git@github.com:hubdrop/web-app.git"
#  revision "HEAD" # or "HEAD" or "TAG_for_1.0" or (subversion) "1234"
#  #user "deploy_ninja"
#  #enable_submodules true
#  #migrate true
#  #migration_command "rake db:migrate"
#  #environment "RAILS_ENV" => "production", "OTHER_ENV" => "foo"
#  shallow_clone true
#  #keep_releases 10
#  action :deploy # or :rollback
#  #restart_command "touch tmp/restart.txt"
#  #git_ssh_wrapper "wrap-ssh4git.sh"
#  #scm_provider Chef::Provider::Git # is the default, for svn: Chef::Provider::Subversion
#end


#
#
# BACK END
#
#
git "/var/hubdrop/scripts" do
  repository "https://github.com/hubdrop/scripts.git"
  reference "master"
  action :sync
  user "hubdrop"
  group "hubdrop"
  #notifies :run, "bash[compile_app_name]"
end

link "/usr/local/bin/hubdrop-create-mirror" do
  to "/var/hubdrop/scripts/hubdrop-create-mirror.php"
end
