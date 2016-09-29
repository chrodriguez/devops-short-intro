chef_role 'web-server' do
  action :delete
end

machine_batch do
  action :destroy
  machines 'web-01', 'web-02', 'proxy'
end

