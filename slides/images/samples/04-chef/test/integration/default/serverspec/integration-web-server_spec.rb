require 'spec_helper'

describe 'web-server::default' do
  describe package('nginx') do
      it { should be_installed }
  end

  describe service('nginx') do
    it { should be_enabled }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe file('/etc/nginx/sites-enabled/default') do
    its(:content) do
      should eq <<-CONF
server {
  listen 80 default_server;
  root /var/www;
  index index.html index.htm;
  server_name www.mikroways.net;

  location / {
    try_files $uri $uri/ =404;
  }

}
      CONF
    end
  end

  describe file('/var/www/index.html') do
    its(:content) { should contain 'Hola mundo!' }
  end
end
