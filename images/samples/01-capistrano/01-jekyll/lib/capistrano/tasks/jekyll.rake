namespace :deploy do
  desc "Build the website with Jekyll"
  task :build do
    on roles(:app) do
      within release_path do
        execute :bundle, "exec", "jekyll", "build", "--config",
          fetch(:configuration, "_config.yml")
      end
    end
  end

  before :publishing, :build
end
