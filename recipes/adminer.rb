directory node['hwdmediashare']['adminer_folder'] do
  owner 'root'
  group 'root'
  mode '0755'
end

remote_file "#{node['hwdmediashare']['adminer_folder']}/index.php" do
  source 'http://downloads.sourceforge.net/adminer/adminer-4.1.0-mysql.php'
  mode '0644'
  owner 'root'
  group 'root'
end

remote_file "#{node['hwdmediashare']['adminer_folder']}/adminer.css" do
  source node['hwdmediashare']['adminer_css_url']
  mode '0644'
  owner 'root'
  group 'root'
end

apache_conf 'adminer' do
  enable true
end
