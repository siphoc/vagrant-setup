# MySQL Configuration
node.set['mysql']['server_debian_password'] = ''
node.set['mysql']['server_root_password'] = ''
node.set['mysql']['server_repl_password'] = ''

include_recipe "mysql::server"
include_recipe "mysql::client"
