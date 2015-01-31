mct_package_file = node['hwdmediashare']['mct']['download_url'].split('/')[-1]

remote_file "#{Chef::Config[:file_cache_path]}/#{mct_package_file}" do
    source node['hwdmediashare']['mct']['download_url']
end

dpkg_package 'omnibus-mct' do
  source "#{Chef::Config[:file_cache_path]}/#{mct_package_file}"
end

%w{ffmpeg qt-faststart yamdi}.each do |binary|
  link "/usr/local/bin/#{binary}" do
    to "/opt/mct/bin/#{binary}"
  end
end
