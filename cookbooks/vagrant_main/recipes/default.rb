include_recipe "apt"
include_recipe "git"
include_recipe "openssl"

node.set_unless['dotfiles']['enable_submodules'] = false
node.set_unless['dotfiles']['shell'] = '/bin/bash'

git 'dotfiles' do
  destination '/home/vagrant/.dotfiles'
  repository node['dotfiles']['repository']
  reference 'master'
  action :sync
  user 'vagrant'
  group 'vagrant'
  enable_submodules node['dotfiles']['enable_submodules']
end

user 'vagrant' do
  action :modify
  shell node['dotfiles']['shell']
end

execute 'install-links' do
  command '/home/vagrant/.dotfiles/' + node['dotfiles']['install']
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/.dotfiles'
  environment ({'HOME' => '/home/vagrant'})
  action :nothing
  subscribes :run, resources(:git => 'dotfiles')
  only_if { File.exists?('/home/vagrant/.dotfiles/' + node['dotfiles']['install']) }
end

# MySQL Configuration
node.set['mysql']['server_debian_password'] = ''
node.set['mysql']['server_root_password'] = ''
node.set['mysql']['server_repl_password'] = ''

include_recipe "mysql::server"
include_recipe "mysql::client"

# WKHTMLToPDF
include_recipe "wkhtmltopdf::default"

# PHP Configuration
include_recipe "yum"
include_recipe "php"
include_recipe "php::module_intl"
include_recipe "php::module_mysql"
include_recipe "php::module_curl"
include_recipe "php-fpm"

# Nginx Configuration
node.set['nginx']['user'] = 'vagrant'

include_recipe "ohai"
include_recipe "nginx"
include_recipe "nginx-fastcgi"

# XHProf and XHGui
include_recipe "xhprof::default"

# MongoDB
include_recipe "mongodb::10gen_repo"
include_recipe "mongodb"

# Set proper nginx configuration
template "/etc/nginx/sites-available/default" do
    source "nginx-config.erb"
    mode 0644
end

service "nginx" do
    action :reload
end

# Use custom php.ini file
template "/etc/php5/php.ini" do
    source "custom-php-config.erb"
    mode 0644
end
template "/etc/php5/cli/php.ini" do
    source "custom-php-config.erb"
    mode 0644
end
template "/etc/php5/fpm/php.ini" do
    source "custom-php-config.erb"
    mode 0644
end

template "/etc/php5/fpm/pool.d/www.conf" do
    source "php-fpm-config.erb"
    mode 0644
end

# Install MongoDB
php_pear "mongo" do
    action :install
end

service "php5-fpm" do
    action :restart
end
