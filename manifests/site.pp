# Default executable path
Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }

# Default file permissions to root:root
File { owner => 'root', group => 'root', }

# Explicitly set 'allow virtual packages to false' in order to suppress error
# message on CentOS.
if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

node default {
  require ::standard_env
  include ::standard_env::tools::cucumber
  include ::esec_client
  include ::webseal_proxy
  include ::deed_api
  include ::borrower_frontend
  include ::stub

  service { 'firewalld':
    ensure => 'stopped',
  }

# create a directory
file { '/opt/logs':
  ensure => 'directory',
  mode   => '0777',
}
}
