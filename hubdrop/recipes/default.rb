
# Install git
include_recipe "apt"

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
directory "/var/hubdrop" do
  owner "hubdrop"
  group "hubdrop"
  mode 00755
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

# Install Apache server
include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_php5"

# Deploy hubdrop Symfony app
# @TODO: Write hubdrop Symfony app

# Deploy hubdrop server scripts
# @TODO: Learn and use deploy LWRP
web_app "hubdrop" do
  server_name node['hostname']
  server_aliases [node['vagrant']['hostname'], 'hubdrop.io']
  #docroot "/var/hubdrop/app/web"
  docroot "/var/www"
end

git "/var/hubdrop/app" do
  repository "https://github.com/hubdrop/web-app.git"
  reference "master"
  action :sync
  user "hubdrop"
  group "hubdrop"
  #notifies :run, "bash[compile_app_name]"
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
