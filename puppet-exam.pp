include nginx
include git

# Create webroot     
file { "/var/www/":
    ensure => "directory",
    mode   => 755
}

git::repo{'puppetlabs':
 path   => '/var/www/',
 source => 'git://github.com/puppetlabs/exercise-webpage.git',
 branch => 'master',
 update => true,

}

# Server config
$puppet_exam_config = "server {
    listen       8000;
    server_name  localhost;


    location / {
        root   /var/www;
        index  index.html index.htm;
    }


    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }



}
"

file { "/etc/nginx/conf.d/puppet-exam.conf":
    ensure => present,
    content => "$puppet_exam_config",
}

