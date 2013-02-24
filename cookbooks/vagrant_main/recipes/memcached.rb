include_recipe "memcached"

php_pear "mongo" do
    action :install
end
