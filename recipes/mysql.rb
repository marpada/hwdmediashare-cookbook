node.set['build_essential']['compiletime'] = true
include_recipe "build-essential"

mysql_service 'default' do
    version '5.6'
    bind_address '0.0.0.0'
    port '3306'
    socket '/var/run/mysqld/mysqld.sock'
    initial_root_password node['mysql']['server_root_password']
    action [:create, :start]
end

mysql_client 'default' do
    action :create
end

template '/root/.my.cnf' do
  owner 'root'
  group 'root'
  mode '0600'
  source 'my.cnf.erb'
end

# Joomla DB and user
 mysql_connection_info = {
   :host     => '127.0.0.1',
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
