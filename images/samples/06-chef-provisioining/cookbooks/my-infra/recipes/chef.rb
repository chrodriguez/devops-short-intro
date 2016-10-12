with_chef_server "https://api.chef.io/organizations/devops-intro",
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]
