# required
set :application, "application name"
set :deploy_to, "/var/www/rails/#{application}"
set :domain, "metajp.com"
set :repository,  "#{scm_username}@#{domain}:#{application}.git"

# extra options
default_run_options[:pty] = true
set :use_sudo, false
set :shared_children, %w(system log pids config)
set :rails_env, 'production'

# defaults
role :app, domain
role :web, domain
role :db,  domain, :primary => true

#----------------------------------------------------------------
# hooks to setup all the fun
#----------------------------------------------------------------

namespace :deploy do
  task :start do; end
  task :stop do; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:setup" do
  db.mysql.setup if Capistrano::CLI.ui.agree("Do you want to create the database, user, and config/database.yml file?")  
  apache.create_vhost if Capistrano::CLI.ui.agree("Do you want to create the apache virtual host file?")  
end
 
after "deploy:symlink", "db:mysql:symlink"
after "deploy:update_code", "rake:rebuild_assets"
after "deploy:symlink", "deploy:update_crontab"