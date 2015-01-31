default['hwdmediashare']['joomla_package_url'] = "http://joomlacode.org/gf/download/frsrelease/19822/161255/Joomla_3.3.6-Stable-Full_Package.tar.gz"
default['hwdmediashare']['hostname'] = node['hostname']
default['hwdmediashare']['docroot'] ='/var/www/hwdmediashare'
default['hwdmediashare']['user'] = 'vagrant'
default['hwdmediashare']['group'] = 'vagrant'
default['hwdmediashare']['mct']['version'] = '0.9.0-1'
default['hwdmediashare']['mct']['download_url'] = "https://s3.amazonaws.com/omnibus-mct/ubuntu/precise/omnibus-mct_#{node['hwdmediashare']['mct']['version']}_amd64.deb"
