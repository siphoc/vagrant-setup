# MongoDB
include_recipe "mongodb::10gen_repo"
include_recipe "mongodb"

# Install MongoDB
php_pear "mongo" do
    action :install
end
