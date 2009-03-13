# http://wiki.glassfish.java.net/Wiki.jsp?page=GlassFishV3CapistranoRecipes
#
# Required capistrano settings:
#
# set :context_root, "/"
# set :glassfish_location, "/your/glassfish/install"
#

namespace :deploy do
  desc "Cold start Glassfish v3"
  task :cold do
    run "#{glassfish_location}/bin/asadmin start-domain domain1"
  end

  desc "Stop a server running Glassfish v3"
  task :stop do
    run "#{glassfish_location}/bin/asadmin undeploy #{current_dir} || true"
    run "#{glassfish_location}/bin/asadmin stop-domain domain1"
  end
  desc "update and deploy to Glassfish v3"
  task :start do
    update run "#{glassfish_location}/bin/asadmin deploy --contextroot #{context_root} #{deploy_to}/#{current_dir}"
  end
  
  desc "restart the application"
  task :restart do
    run "#{glassfish_location}/bin/asadmin deploy --force=true --contextroot #{context_root} #{deploy_to}/#{current_dir}"
  end
  
  desc "Undeploy the application"
  task :undeploy do
    run "#{glassfish_location}/bin/asadmin undeploy #{current_dir}"
  end
end


