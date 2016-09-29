include_recipe 'chef-apt-docker'

docker_installation_package 'default' do
  action :create
  version node['my_rancher']['docker']['version']
  package_options %q|--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'| # if Ubuntu for example
end

docker_service 'default' do
  action [:create, :start]
end

docker_image 'rancher/server' do
    tag node['my_rancher']['server']['version']
end

docker_container 'rancher-server' do
  image 'rancher/server'
  tag node['my_rancher']['server']['version']
  container_name 'rancher-server'
  port "80:8080"
  restart_policy 'always'
  action :run
end
