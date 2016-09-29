def db_hash
  {
    'name'      => fetch(:wp_DB_NAME),
    'user'      => fetch(:wp_DB_USER),
    'password'  => fetch(:wp_DB_PASSWORD),
    'host'      => fetch(:wp_DB_HOST)
  }
end

def local_db_hash
  Hash[%w(PASSWORD USER HOST NAME).map do |field|
    regexp = %r{['"]DB_#{field}['"]}
    define = File.read('my-site/wp-config.php').split("\n").flatten.select{|x| x =~ regexp }.first
    [field.downcase, define.gsub(%r{define\(\s*['"]DB_#{field}['"]\s*,\s*['"](.*)['"]\)\s*;.*}, '\1')]
  end]
end

namespace :wp do
  task :config do
    on roles(:app) do
      within shared_path do
        secret_keys = capture("curl -s -k https://api.wordpress.org/secret-key/1.1/salt")
        database = db_hash
        wp_config = ERB.new(File.read('config/templates/wp-config.php.erb')).result(binding)
        io = StringIO.new(wp_config)
        upload! io, File.join(shared_path, "wp-config.php")
        execute "chmod +r #{shared_path}/wp-config.php"
      end
    end
  end
  before 'deploy:check:linked_files', 'wp:config'

  desc "Upload themes, plugins and uploads to server"
  task :upload do
    roles(:app).each do |role|
      run_locally do
        execute :rsync, "-azv --rsh=ssh --progress", "#{fetch(:wp_local_copy,)}/wp-content/", "#{role.user}@#{role.hostname}:#{shared_path}/wp-content"
      end
    end
  end

  desc "Upload themes, plugins and uploads to server"
  task :download do
    role = roles(:app).first
    execute :rsync, "-azv --rsh=ssh --progress", "#{role.user}@#{role.hostname}:#{shared_path}/wp-content/", "#{fetch(:wp_local_copy,)}/wp-content"
  end

  namespace :db do
    desc "Pull remote database from server as local dump"
    task :pull do
      on roles(:app) do
        database = db_hash
        file ="/tmp/wordpress-#{Time.now.strftime("%F%T").gsub(/[-:]/,'')}.sql"
        execute :mysqldump, "-u #{database['user']} -p#{database['password']} -h#{database['host']} #{database['name']}", "> #{file}"
        download! file, '/tmp'
        run_locally do
          database = local_db_hash
          execute "mysql -u #{database['user']} -p#{database['password']} -h#{database['host']} #{database['name']} < #{file}"
        end
      end
    end

    desc "Push local database to server and load it! DANGER"
    task :push do
      database = local_db_hash
      file ="/tmp/wordpress-#{Time.now.strftime("%F%T").gsub(/[-:]/,'')}.sql"
      run_locally do
        execute "mysqldump -u #{database['user']} -p#{database['password']} -h#{database['host']} #{database['name']} > #{file}"
      end
      on roles(:app) do
        upload! file, '/tmp'
        database = db_hash
        execute "mysql -u #{database['user']} -p#{database['password']} -h#{database['host']} #{database['name']} < #{file}"
      end
    end
  end
end
