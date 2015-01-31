include_recipe 'php'
include_recipe 'php-fpm'

%w{mcrypt gd mysql curl imap imagick mhash }.each do |m|
  package "php5-#{m}" do
    action :install
  end

    execute "enable php5-#{m}" do
      command "php5enmod #{m}"
      only_if "which php5enmod"
    end
end

php_fpm_pool "www" do
    enable false
end

php_options = ''

node['hwdmediashare']['php']['options'].each do |k,v|
  php_options << "php_admin_value[#{k}] => '#{v}', "
end

pool_php_options = {}

node['hwdmediashare']['php']['options'].each do |k,v|
  pool_php_options["php_admin_value[#{k}]"] = v
end


php_fpm_pool "hwdmediashare" do
    user node['hwdmediashare']['user']
    group node['hwdmediashare']['group']
    process_manager node['hwdmediashare']['php']['process_manager']
    listen  node['hwdmediashare']['php']['fpm_socket']
    max_children  node['hwdmediashare']['php']['max_children']
    min_spare_servers  node['hwdmediashare']['php']['min_spare_servers']
    max_spare_servers  node['hwdmediashare']['php']['max_spare_servers']
    php_options pool_php_options
end

