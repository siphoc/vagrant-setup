node.set['dotfiles']['enable_submodules'] = false
node.set['dotfiles']['shell'] = '/bin/bash'
node.set['dotfiles']['repository'] = 'git://github.com/wijs/dotfiles-server.git'

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
