include_recipe "apache2"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_fastcgi"
include_recipe 'apache2::mod_actions'
include_recipe 'apache2::mod_fastcgi'
include_recipe 'apache2::mod_expires'
include_recipe 'apache2::mod_headers'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_cgi'

package 'apache2-dev'

package 'apache2-suexec' do
  action :install
end
apache_module "suexec" do
  conf false
end
directory node['hwdmediashare']['docroot'] do
  owner node['hwdmediashare']['user']
  group node['hwdmediashare']['group']
  mode '0775'
end


if node['hwdmediashare']['enable_ssl']
  unless node['hwdmediashare']['ssl_certificate_key'] && node['hwdmediashare']['ssl_certificate']
    package 'ssl-cert'
    execute 'gen_snakeoil-cert' do
      command "/usr/sbin/make-ssl-cert generate-default-snakeoil --force-overwrite"
      creates "/etc/ssl/certs/ssl-cert-snakeoil.pem"
      end
  end
  ssl_certificate = node['hwdmediashare']['ssl_certificate'] || "/etc/ssl/certs/ssl-cert-snakeoil.pem"
  ssl_certificate_key = node['hwdmediashare']['ssl_certificate_key'] || '/etc/ssl/private/ssl-cert-snakeoil.key'
end

 web_app "hwdmediashare" do
   docroot node['hwdmediashare']['docroot'] 
   template 'web_app.conf.erb'
   server_name node['hwdmediashare']['hostname']
   allow_override "All"
   ssl_enabled node['hwdmediashare']['enable_ssl']
   user node['hwdmediashare']['user']
   ssl_certificate_file ssl_certificate
   ssl_certificate_key_file  ssl_certificate_key
   group node['hwdmediashare']['group']
end

# mod_h264
remote_file "/usr/local/src/apache_mod_h264_streaming-2.2.7.tar.gz" do
  source "http://h264.code-shop.com/download/apache_mod_h264_streaming-2.2.7.tar.gz"
  checksum "9ab80d038d83af453919bd9d5bed0e9e34f1469a8901146698ff6fd4e164fdc0"
end 

execute "build_mod_h264" do
  cwd "/usr/local/src"
  command <<-EOH
  tar xzf apache_mod_h264_streaming-2.2.7.tar.gz
  cd mod_h264_streaming-2.2.7 && ./configure && make && make install
  EOH
  not_if "test -f #{node['apache']['libexec_dir']}/mod_h264_streaming.so"
end

apache_module "h264_streaming" do
  conf true
  filename "mod_h264_streaming.so"
end
