include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'database::mysql'

# Joomla DB and user
 mysql_connection_info = {
   :host     => 'localhost',
   :username => 'root',
   :password => node['mysql']['server_root_password']
  }

mysql_database node['hwdmediashare']['mysql']['joomla_db_name'] do
    connection mysql_connection_info
    action :create
end

mysql_database_user node['hwdmediashare']['mysql']['joomla_db_user'] do
    connection mysql_connection_info
    database_name node['hwdmediashare']['mysql']['joomla_db_name'] 
    password node['hwdmediashare']['mysql']['joomla_db_password'] 
    privileges [:all]
    action :grant
end
