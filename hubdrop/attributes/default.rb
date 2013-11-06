
# Generate and deploy aegir ssh key to github
node.set['github_deploys']['deploy_user'] = "hubdrop"
node.set['github_deploys']['deploy_group'] = "hubdrop"
node.set['github_deploys']['deploy_home_path'] = "/var"

node.set['github_deploys']['github_api']['endpoint_path'] = "/user/keys"
node.set['github_deploys']['github_api']['username'] = "devudo-deploy"
node.set['github_deploys']['github_api']['email'] = "jon@devudo.com"
node.set['github_deploys']['github_api']['password'] = "wakkawakka123"
node.set['github_deploys']['github_api']['user_agent'] = "HubDrop/1.0"
