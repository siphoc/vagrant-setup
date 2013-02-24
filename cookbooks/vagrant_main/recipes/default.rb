include_recipe "git"
include_recipe "openssl"
include_recipe "wkhtmltopdf::default"

include_recipe "vagrant_main::dotfiles"
include_recipe "vagrant_main::php"
include_recipe "vagrant_main::mysql"
include_recipe "vagrant_main::nginx"
include_recipe "vagrant_main::mongodb"
include_recipe "vagrant_main::memcached"

include_recipe "xhprof::default"

service "php5-fpm" do
    action :restart
end
