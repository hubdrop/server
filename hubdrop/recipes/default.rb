# Include Recipes
include_recipe "apt"

# Web Server
include_recipe "apache2::mod_php5"
include_recipe "php::module_curl"

# Jenkins
# @TODO: Jenkins installer doesn't setup /var/run/jenkins?
directory "/var/run/jenkins" do
  action :create
end
include_recipe "jenkins::server"

# Jenkins Jobs
git_branch = 'master'
jobs = ["hubdrop-jenkins-create-mirror", "hubdrop-jenkins-update-mirrors"]
jenkins_home = node['jenkins']['server']['home'];


# Create all jobs
jobs.each{|job_name|

  job_config_path = File.join("#{jenkins_home}/jobs/#{job_name}/config.xml")

  # Create Job Directory
  directory "#{jenkins_home}/jobs/#{job_name}" do
    action :create
    owner "jenkins"
    group "jenkins"
  end

  # Job Chef Resource
  jenkins_job job_name do
    action :nothing
    config job_config_path
  end

  # Jenkins Job Template.
  template job_config_path do
    source "hubdrop-jenkins-create-mirror-config.xml.erb"
    owner "jenkins"
    group "jenkins"
    variables :job_name => job_name, :branch => git_branch, :node => node[:fqdn]
    notifies :update, resources(:jenkins_job => job_name), :immediately
    notifies :build, resources(:jenkins_job => job_name), :immediately
  end
}

# Jenkins special commands

# grant jenkins user ability to run "sudo hubdrop-jenkins-create-mirror"
cookbook_file "/etc/sudoers.d/jenkins" do
  source "sudoers.d/jenkins"
  action :create
  backup false
  owner "root"
  group "root"
  mode 00440
end

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
# Add jenkins to www-data group
group "www-data" do
  action :modify
  members "jenkins"
  append true
end
# Add jenkins to www-data group
group "hubdrop" do
  action :modify
  members "jenkins"
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


# Setup its ssh keys
path_to_key = "/var/hubdrop/.ssh/id_rsa"
log "[HUBDROP] Generating ssh keys for hubdrop user"

unless File.exists?(path_to_key)
  execute "hubdrop-ssh-keys" do
    user "hubdrop"
    creates "#{path_to_key}.pub"
    command "ssh-keygen -t rsa -q -f #{path_to_key} -P \"\""
  end
  log "[HUBDROP] Key generation complete"

  # Add aegir's public key to our repos
  log "[HUBDROP] Uploading key to github account for #{node[:github_deploys][:github_api][:username]}"
  ruby_block "upload_key_to_github" do
    block do
      class Chef::Resource::RubyBlock
        include GithubAPI
      end
      upload_key(
        node[:github_deploys][:github_api][:email],
        node[:github_deploys][:github_api][:password],
        node[:fqdn],
        "#{path_to_key}.pub")
    end
  end
  log "[HUBDROP] Public Key uploaded to github:"
end


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
  server_aliases []
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

# HubDrop Create Mirror
link "/usr/local/bin/hubdrop-create-mirror" do
  to "/var/hubdrop/scripts/hubdrop-create-mirror.php"
end

# HubDrop update mirrors
link "/usr/local/bin/hubdrop-update-mirrors" do
  to "/var/hubdrop/scripts/hubdrop-update-mirrors.php"
end

# grant jenkins user ability to run "sudo hubdrop-jenkins-create-mirror"
file "/usr/bin/hubdrop-jenkins-create-mirror" do
  content '#!/bin/bash
sudo su - hubdrop -c "hubdrop-create-mirror $1 $2"'
  backup false
  owner "root"
  group "root"
  mode 00755
end
# grant jenkins user ability to run "sudo hubdrop-jenkins-update-mirrors"
file "/usr/bin/hubdrop-jenkins-update-mirrors" do
  content '#!/bin/bash
sudo su - hubdrop -c "hubdrop-update-mirrors $1 $2"'
  backup false
  owner "root"
  group "root"
  mode 00755
end

# Command for jenkins-cli
file "/usr/bin/jenkins-cli" do
  content '#!/bin/bash
java -jar /home/jenkins/jenkins-cli.jar  -s http://localhost:8080/ $1 $2 $3 $4'
  backup false
  owner "root"
  group "root"
  mode 00755
end
file "/home/jenkins/jenkins-cli.jar" do
  mode "644"
  action :touch
end
