lock '3.5.0'

set :application, 'capistrano-sample'
set :repo_url, 'git@github.com:Mikroways/mikroways.net.git'
#set :branch, 'demo-capistrano-curso'
set :deploy_to, '/opt/sites/jekyll'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.0'
set :rbenv_roles, :app
set :bundle_roles, :app
