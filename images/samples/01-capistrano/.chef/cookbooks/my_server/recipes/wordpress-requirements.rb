package 'php5-fpm'
package 'php5-mysql'

directory '/opt/sites/wordpress' do
  recursive true
  owner 'vagrant'
end

execute 'clone repo' do
  command 'git clone --mirror --depth 1 --no-single-branch https://github.com/WordPress/WordPress.git /opt/sites/wordpress/repo'
  creates '/opt/sites/wordpress/repo'
  user 'vagrant'
  group 'vagrant'
end


mysql_service 'default' do
  initial_root_password 'change me'
  action [:create, :start]
end

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => 'change me'
}

mysql2_chef_gem 'default' do
  action :install
end

mysql_database 'wordpress' do
  connection mysql_connection_info
end

mysql_database_user 'wordpress' do
  connection mysql_connection_info
  password      'pass_wordpress'
  database_name 'wordpress'
  host          '%'
  action        [:create, :grant ]
end

