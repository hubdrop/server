

# Install Jenkins server
# include_recipe "jenkins::server"

# Deploy hubdrop Symfony app
# @TODO: Write hubdrop Symfony app
# @TODO: Learn and use deploy LWRP

# Deploy hubdrop server scripts
# @TODO: Learn and use deploy LWRP
directory "/var/web-app" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

deploy "/var/web-app" do
  repo "git@github.com:hubdrop/web-app.git"
  revision "HEAD" # or "HEAD" or "TAG_for_1.0" or (subversion) "1234"
  #user "deploy_ninja"
  #enable_submodules true
  #migrate true
  #migration_command "rake db:migrate"
  #environment "RAILS_ENV" => "production", "OTHER_ENV" => "foo"
  shallow_clone true
  #keep_releases 10
  action :deploy # or :rollback
  #restart_command "touch tmp/restart.txt"
  #git_ssh_wrapper "wrap-ssh4git.sh"
  #scm_provider Chef::Provider::Git # is the default, for svn: Chef::Provider::Subversion
end
