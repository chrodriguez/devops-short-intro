require 'spec_helper'

describe 'web-server::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.automatic[:ipaddress] = '1.1.1.1'
      node.automatic[:cpu][:total] = 100
      node.automatic[:memory][:total] = '640kb enough'
    end.converge(described_recipe)
  end

  context 'behaves as expected' do
    it 'installs nginx' do
      expect(chef_run).to install_package('nginx')
    end

    it 'starts and enable service nginx' do
      expect(chef_run).to enable_service('nginx')
      expect(chef_run).to start_service('nginx')
    end

    it 'configures nginx' do
      expect(chef_run).to create_template('/etc/nginx/sites-enabled/default')
        .with(
          source: 'nginx-default.conf.erb',
          variables: {
            server_name: 'www.mikroways.net',
            document_root: '/var/www'
          }
        )
    end

    it 'notifies service to restart when configured' do
      template = chef_run.template('/etc/nginx/sites-enabled/default')
      expect(template).to notify('service[nginx]').to(:restart).immediately
    end

    it 'creates directory for webpages' do
      expect(chef_run).to create_directory('/var/www')
    end

    it 'creates a landing page' do
      node = chef_run.node
      expect(chef_run).to render_file('/var/www/index.html').with_content(<<-HTML
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
                                                                         )
    end
  end
end
