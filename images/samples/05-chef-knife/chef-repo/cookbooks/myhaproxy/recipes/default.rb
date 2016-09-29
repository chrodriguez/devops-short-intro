all_web_servers = search(:node, "role:web-server")
members = []
all_web_servers.each do |web|
  members <<
  {
    "hostname"  => web['cloud']['public_hostname'],
    "ipaddress" => web['cloud']['public_ipv4'],
    "port"      => 80,
    "ssl_port"  => 80
  }
end
node.default['haproxy']['members'] = members

include_recipe 'haproxy'
