include_recipe "memcached"

package "libmemcached-dev" do
    action :install
end

php_pear "memcached" do
    action :install
end
