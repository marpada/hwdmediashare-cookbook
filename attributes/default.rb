default['hwdmediashare']['hostname'] = node['hostname']
default['hwdmediashare']['docroot'] ='/var/www/hwdmediashare'
default['hwdmediashare']['user'] = 'www-data'
default['hwdmediashare']['group'] = 'www-data'
default['hwdmediashare']['mct']['version'] = '0.9.0-1'
default['hwdmediashare']['mct']['download_url'] = "https://s3.amazonaws.com/omnibus-mct/ubuntu/precise/omnibus-mct_#{node['hwdmediashare']['mct']['version']}_amd64.deb"
