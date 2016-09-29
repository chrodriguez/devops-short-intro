role :app, %w{vagrant@33.33.33.10}

server '33.33.33.10',
   roles: %w(app),
   ssh_options: {
     user: 'vagrant', # overrides user setting above
     forward_agent: true,
     auth_methods: %w(publickey password),
     password: 'vagrant'
   }
