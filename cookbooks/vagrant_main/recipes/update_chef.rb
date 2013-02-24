include_recipe "apt"

execute 'install chef 10.16.4' do
    command 'sudo gem install chef -v 10.16.4'
end
