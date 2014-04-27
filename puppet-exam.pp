# Paul Gibson - gibson.a.paul@gmail.com

include nginx
include git

# Create web root directory     
file { "/var/www/":
    ensure => "directory",
    mode   => 755
}

# Clone git repo to web root
git::repo{'puppetlabs':
 path   => '/var/www/',
 source => 'git://github.com/puppetlabs/exercise-webpage.git',
 branch => 'master',
 update => true,

}

# Server config variable
$puppet_exam_config = "server {
    listen       8000;
    server_name  localhost;


    location / {
        root   /var/www;
        index  index.html index.htm;
    }

    location ~ /\\.  { return 403; }


    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }



}
"

# Copy server config variable to file
file { "/etc/nginx/conf.d/puppet-exam.conf":
    ensure => present,
    content => "$puppet_exam_config",
    notify  => Service["nginx"]
}
