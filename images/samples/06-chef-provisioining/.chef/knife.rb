# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "car"
client_key               "#{current_dir}/car.pem"
validation_client_name   "devops-intro-validator"
validation_key           "#{current_dir}/devops-intro-validator.pem"
chef_server_url          "https://api.chef.io/organizations/devops-intro"
cookbook_path            ["#{current_dir}/../cookbooks"]

knife[:aws_credential_file] = File.join(ENV['HOME'], "/.aws/credentials")
knife[:aws_profile] = "mikroways"
knife[:region] = 'us-west-2'
knife[:ssh_key_name] = 'car'
