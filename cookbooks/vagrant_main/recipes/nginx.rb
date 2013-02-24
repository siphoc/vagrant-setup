# Nginx Configuration
node.set['nginx']['user'] = 'vagrant'

include_recipe "ohai"
include_recipe "nginx"

# Set proper nginx configuration
template "/etc/nginx/sites-available/default" do
    source "nginx-config.erb"
    mode 0644
end

service "nginx" do
    action :reload
end
