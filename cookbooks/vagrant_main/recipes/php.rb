# PHP Configuration
include_recipe "yum"
include_recipe "php"

# PHP Intl
case node['platform']
when "centos", "redhat", "fedora"
  # unknown the state of this OS so leaving
when "debian", "ubuntu"
  package "php5-intl" do
    action :upgrade
  end
end

include_recipe "php::module_mysql"
include_recipe "php::module_curl"
include_recipe "php-fpm"


# PHP XDebug
case node['platform']
when "centos", "redhat", "fedora"
  # unknown the state of this OS so leaving
when "debian", "ubuntu"
  package "php5-xdebug" do
    action :upgrade
  end
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
