
# General settings
default['hubdrop']['paths']['home']  = '/var/hubdrop'
default['hubdrop']['paths']['app']  = '/var/hubdrop/app'
default['hubdrop']['paths']['repos']  = '/var/hubdrop/repos'

# Generate and deploy aegir ssh key to github
node.set['github_deploys']['deploy_user'] = "hubdrop"
node.set['github_deploys']['deploy_group'] = "hubdrop"
node.set['github_deploys']['deploy_home_path'] = "/var"

node.set['github_deploys']['github_api']['endpoint_path'] = "/user/keys"
node.set['github_deploys']['github_api']['username'] = "hubdrop-user"
node.set['github_deploys']['github_api']['email'] = "jon+hubdrop@thinkdrop.net"
node.set['github_deploys']['github_api']['user_agent'] = "HubDrop/1.0"

