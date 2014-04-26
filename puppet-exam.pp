include nginx

nginx::resource::vhost { 'test.local:8000':
  ensure       => present,
  listen_port  => 8000,
  server_name  => ['test'],
  www_root     => '/var/www/'
}

# Create webroot     
file { "/var/www/":
    ensure => "directory",
    mode   => 755
}

package { 'git':
    ensure => "installed",
}

vcsrepo { "/var/www/":
  ensure => latest,
  provider => git,
  require  => [ Package["git"] ],
  source => 'git://github.com/puppetlabs/exercise-webpage.git',
  revision => 'master'
}

# Delete default nginx config
file { "/etc/nginx/conf.d/default.conf":
  ensure => absent,
}
