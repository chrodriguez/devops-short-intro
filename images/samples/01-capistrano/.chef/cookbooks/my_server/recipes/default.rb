# Corre apt-get update
include_recipe 'apt'

# Instala el paquete nginx
package 'nginx'

# Instala el paquete git para descargar los sitios
package 'git'

include_recipe 'my_server::jekyll-requirements'
include_recipe 'my_server::wordpress-requirements'

service 'nginx' do
  action [:enable, :start]
end


file '/etc/nginx/sites-enabled/default' do
  content <<-NGINX

server {
  listen 80 default_server;
  root /opt/sites/jekyll/current/_site;
  index index.html index.htm;
  server_name _;

  location / {
    try_files $uri $uri/ =404;
  }


}


upstream php {
    server unix:/var/run/php5-fpm.sock;
}

server {
  listen 81 default_server;
  root /opt/sites/wordpress/current;
  index index.php;
  server_name _;


  location / {
    try_files $uri $uri/ /index.php?$args;
  }

  location ~ [^/]\.php(/|$) {
    fastcgi_split_path_info ^(.+?\.php)(/.*)$;
    if (!-f $document_root$fastcgi_script_name) {
      return 404;
    }

    include fastcgi_params;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_pass php;
  }

}

  NGINX
  notifies :restart, 'service[nginx]'
end
