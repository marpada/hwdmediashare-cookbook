name             'hwdmediashare'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures chef-hwd'
long_description 'Installs/Configures chef-hwd'
version          '0.1.0'

depends 'build-essential'
depends 'git'
depends 'curl'
depends 'apache2'
depends 'database'
depends 'mysql', "~> 4.1.2"
depends 'database'
depends 'php'
depends 'php-fpm'
depends 'mysql2_chef_gem', "< 1.0.0"
