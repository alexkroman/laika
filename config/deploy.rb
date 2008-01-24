require 'mongrel_cluster/recipes'

set :application, "laika"
set :repository,  "https://laika.svn.sourceforge.net/svnroot/laika/trunk"
set :deploy_to, "/var/www/apps/#{application}"
#set :runner, "mongrel_user"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :domain, "laika.mitre.org"
role :app, domain
role :web, domain
role :db,  domain, :primary => true
set :rails_env, "development"

set :user, # SET TO THE APP USER
set :group, 'deploy'

# Setup Mongrel
set :mongrel_servers, 2
set :mongrel_port, 9000
set :mongrel_address, "127.0.0.1"
set :mongrel_environment, rails_env
set :mongrel_config, "/etc/mongrel_cluster/#{application}.conf"
set :mongrel_user, user
set :mongrel_group, group
default_run_options[:pty] = true

 