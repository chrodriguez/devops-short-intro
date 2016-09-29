namespace :deploy do
  desc 'Notify service of deployment'
  task :notify do
    run_locally do
        execute "google-chrome http://#{roles(:app).first.hostname}"
    end
  end

  after :finished, :notify
end
