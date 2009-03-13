#
# This deploy script is designed to deploy Laika to a configured Amazon EC2
# instance.
#
# To deploy Laika, go to the parent directory and type 'cap deploy'
#

#
# You must specify scm_username, scm_password and server_name in deploy_local.rb.
#
load File.dirname(__FILE__) + '/deploy_local.rb'

#
# In order to automatically authenticate via SSH you must add the correct
# PEM key to your ssh-agent:
#
#  $ ssh-add $YOUR_AMAZON_SSH_PEM_KEY
#
set :ssh_options, { :forward_agent => true }

# glassfish config, see lib/recipes/glassfish.rb
set :context_root, "/"
set :glassfish_location, "/usr/local/glassfish"

# FIXME For now, we are deploying to EC2 as the root user.
set :user, 'root'
set :user_sudo, false

# application-specific configuration
set :application, 'laika'
set :repository,  'https://laika.svn.sourceforge.net/svnroot/laika/webapp/trunk'
set :deploy_to,   '/var/www'
set :rails_env,   'production'
set :rake,        '/usr/local/jruby/bin/jruby -S rake'

role :app, server_name
role :web, server_name
role :db,  server_name, :primary => true

namespace :deploy do
  after  "deploy:update_code", "deploy:copy_production_configuration"
  #after "deploy:copy_production_configuration", "deploy:symlink_vendor_plugins"
  # before "deploy:migrate",     "deploy:create_production_database"
  #after  "deploy:restart",     "deploy:backgroundrb_restart"

  configurations = {
    "database.yml"   => "#{shared_path}/config/database.yml",
  }

  desc "Copy production configuration files stored on the same remote server"
  task :copy_production_configuration, :roles => :app do
    configurations.each_pair do |file, src|
      run "cp #{src} #{release_path}/config/#{file}"
    end
  end
end


