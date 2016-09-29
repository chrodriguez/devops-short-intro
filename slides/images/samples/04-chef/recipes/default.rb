package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

template '/etc/nginx/sites-enabled/default' do
  source 'nginx-default.conf.erb'
  variables(
    server_name: 'www.mikroways.net',
    document_root: '/var/www'
  )
  notifies :restart, 'service[nginx]', :immediately
end

directory '/var/www'

file '/var/www/index.html' do
  content <<-HTML
<html>
  <body>
    <h1>Hola mundo!</h1>
    <ul>
      <li> IP: #{node.ipaddress} </li>
      <li> CPU: #{node.cpu.total} </li>
      <li> MEM: #{node.memory.total} </li>
    </ul>
  </body>
</html>
  HTML
end
