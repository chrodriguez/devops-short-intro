role :app, %w{vagrant@33.33.33.10}

server '33.33.33.10',
   roles: %w(app),
   ssh_options: {
     user: 'vagrant', # overrides user setting above
     forward_agent: true,
     auth_methods: %w(publickey password),
     password: 'vagrant'
   }

set :wp_DB_NAME,           'wordpress'
set :wp_DB_USER,           'wordpress'
set :wp_DB_PASSWORD,       'pass_wordpress'
set :wp_DB_HOST,           '127.0.0.1'
