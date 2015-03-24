include_recipe 'mysql::server'

# Joomla DB and user
execute "Create hwdmediashare DB" do
    command "mysql -e \'CREATE DATABASE #{node['hwdmediashare']['mysql']['joomla_db_name']}\' -uroot -p#{node['mysql']['server_root_password']}"
    not_if "mysql -e \'SHOW DATABASES\' -uroot -p#{node['mysql']['server_root_password']}  | grep -q #{node['hwdmediashare']['mysql']['joomla_db_name']}"
end


execute "Create hwdmediashare User" do
    command %Q{mysql -e 'GRANT ALL ON #{node['hwdmediashare']['mysql']['joomla_db_name']}.* TO '#{node['hwdmediashare']['mysql']['joomla_db_user']}'@'localhost' IDENTIFIED BY "#{node['hwdmediashare']['mysql']['joomla_db_password']}" '  -uroot -p#{node['mysql']['server_root_password']}}
end
