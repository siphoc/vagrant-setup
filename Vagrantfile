# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "debian-squeeze"

  # For those that don't have this box installed, add the download link.
  config.vm.box_url = "https://www.dropbox.com/s/2ozchg0ub9d428a/debian-squeeze-64.box?dl=1"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 4567

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  # First we need to upgrade chef since some cookbooks require version >=10.16.4
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe('vagrant_main::update_chef')
  end

  # Install all cookbooks
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe('vagrant_main::default')

    chef.json.merge!({
      :dotfiles => {
        :repository => "git://github.com/wijs/dotfiles-server.git",
        :enable_submodules => false,
        :shell => '/bin/bash',
        :install => 'install_unattended.sh'
      }
    })
  end

  # Use NFS for our shared folders. This allows our application to run much
  # faster.
  config.vm.share_folder "v-root", "/vagrant", "." , :nfs => true
  config.vm.customize [
    "setextradata", :id,
    "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"
  ]

  # Add more memory to our box
  config.vm.customize ["modifyvm", :id, "--memory", "800"]
end
