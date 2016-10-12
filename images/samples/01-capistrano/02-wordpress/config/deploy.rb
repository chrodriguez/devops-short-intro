# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'my_wordpress'
set :repo_url, 'https://github.com/WordPress/WordPress.git'
set :deploy_to, '/opt/sites/wordpress'
set :git_shallow_clone, 1
set :wp_local_copy, 'my-site'


set :branch, '4.5.2'

set :linked_files, fetch(:linked_files, []).push('wp-config.php')

set :linked_dirs, fetch(:linked_dirs, []).push('wp-content/languages', 'wp-content/plugins', 'wp-content/themes', 'wp-content/uploads')


set :wp_DB_NAME,           'wordpress_devops'
set :wp_DB_USER,           'wordpress'
set :wp_DB_PASSWORD,       'wordpress'
set :wp_DB_HOST,           '127.0.0.1'
