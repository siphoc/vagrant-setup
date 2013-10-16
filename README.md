# Vagrant setup
This is a basic Vagrant setup used for Siphoc projects.

## Orientation
This setup is useful for PHP development. It includes the following packages:

* PHP 5.3
* PHP-FPM (Used by NGINX)
* MongoDB (+ PHP Driver)
* MySQL (+ PHP Driver)
* Memcached (+ PHP Driver)
* PHPIntl
* PHP Curl module
* XDebug (+ PHP Driver)

It is focused on Symfony2 development (using the web/ folder as root).

### Additional packages
* wkthmltopdf
* XHProf + XHGUI (+ Domain, see NGINX config)

## Installation

### Submodules
Install the git submodules (`git submodule update`).

### Nginx
Copy these files into your project and alter the nginx configuration to point
to your projects with a proper domain. Do not forget to add these domains to
your hosts file on your own machine.

You can find the config file under nginx-config.erb. The defaut url will be
`vagrant-project.dev`. (.prod is also available + xip.io domains).

Note that these configs are focused on Symfony2 development and thus point to
those folders used by Symfony2.

### XHProf
If you're using XHProf, you should change the config file (xhprof-config.erb)
with the correct database information.
