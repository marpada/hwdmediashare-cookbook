group node['hwdmediashare']['group']

user node['hwdmediashare']['user'] do
  gid node['hwdmediashare']['group']
end

joomla_package = node['hwdmediashare']['joomla_package_url'].gsub(/^(.*\/)/,'')
remote_file "#{Chef::Config[:file_cache_path]}/#{joomla_package}" do
    source node['hwdmediashare']['joomla_package_url']
end

execute 'unpack joomla' do
  user node['hwdmediashare']['user']
  command "tar xzf #{Chef::Config[:file_cache_path]}/#{joomla_package} -C #{node['hwdmediashare']['docroot']}"
  creates "#{node['hwdmediashare']['docroot']}/index.php"
end

directory "#{node['hwdmediashare']['docroot']}/cgi-bin" do
  owner node['hwdmediashare']['user']
  group node['hwdmediashare']['group']
  mode 0755
end

cookbook_file "#{node['hwdmediashare']['docroot']}/cgi-bin/ubr_upload.pl" do
  source 'ubr_upload.pl'
  owner node['hwdmediashare']['user']
  group node['hwdmediashare']['group']
  mode 0755
end
