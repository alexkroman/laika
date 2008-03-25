require 'mongrel_cluster/recipes'
require 'yaml'

settings = YAML::load_file('config/deploy_settings.yml')
server_settings = settings[ENV['deploy_environment']]

set :application, server_settings['app_name']
set :repository,  "https://laika.svn.sourceforge.net/svnroot/laika/webapp/trunk"
set :deploy_to, "/var/www/apps/#{application}"
#set :runner, "mongrel_user"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :domain, server_settings['domain']
role :app, domain
role :web, domain
role :db,  domain, :primary => true
set :rails_env, server_settings['rails_env']

set :user, # SET TO THE APP USER
set :group, 'deploy'

# Setup Mongrel
set :mongrel_servers, 2
set :mongrel_port, server_settings['mongrel_port']
set :mongrel_address, "127.0.0.1"
set :mongrel_environment, rails_env
set :mongrel_config, "/etc/mongrel_cluster/#{application}.conf"
set :mongrel_user, user
set :mongrel_group, group
default_run_options[:pty] = true

desc "Copy necessary config files to server"
task :after_update_code do
  put(File.read("config/mongrel_cluster.yml"), "#{release_path}/config/mongrel_cluster.yml", :mode => 0660)
  put(File.read("config/database.yml"), "#{release_path}/config/database.yml", :mode => 0660)
  #run <<-CMD
  #  sed -i -e '1 i ActionController::AbstractRequest.relative_url_root = "/laika"' #{release_path}/config/routes.rb
  #CMD
  run "ln -s #{shared_path}/clinical_documents #{release_path}/public/clinical_documents"
  sudo "chgrp apache #{release_path}/config/{database.yml,mongrel_cluster.yml}"
  sudo "chgrp apache #{release_path}/tmp"
end 

desc "Add our own directories to the shared folder"
task :after_setup, :roles => [:web, :app] do
  run "mkdir -p -m 775 #{shared_path}/clinical_documents"
  sudo "chgrp apache #{shared_path}/clinical_documents"
end

desc "Restart the web server"
task :restart, :roles => :app do
  sudo "/usr/sbin/apachectl graceful"
end 