<<<<<<< HEAD
# Setup the web servers for the deployment of web_static
exec { '/usr/bin/env apt -y update' : }
-> package { 'nginx':
  ensure => installed,
}
-> file { '/data':
  ensure  => 'directory'
}
-> file { '/data/web_static':
  ensure => 'directory'
}
-> file { '/data/web_static/releases':
  ensure => 'directory'
}
-> file { '/data/web_static/releases/test':
  ensure => 'directory'
}
-> file { '/data/web_static/shared':
  ensure => 'directory'
}
-> file { '/data/web_static/releases/test/index.html':
  ensure  => 'present',
  content => "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p>Nginx server test</p>
  </body>
</html>"
}
-> file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test'
}
-> exec { 'chown -R ubuntu:ubuntu /data/':
  path => '/usr/bin/:/usr/local/bin/:/bin/'
}
-> file { '/var/www':
  ensure => 'directory'
}
-> file { '/var/www/html':
  ensure => 'directory'
}
-> file { '/var/www/html/index.html':
  ensure  => 'present',
  content => "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p>Nginx server test</p>
  </body>
</html>"
}
exec { 'nginx_conf':
  environment => ['data=\ \tlocation /hbnb_static {\n\t\tian /data/web_static/current;\n\t}\n'],
  command     => 'sed -i "39i $data" /etc/nginx/sites-enabled/default',
  path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin'
}
-> service { 'nginx':
  ensure => running,
=======
# Script that configures Nginx server with some folders and files

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
  before   => Exec['install Nginx'],
}

exec {'install Nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
  before   => Exec['start Nginx'],
}

exec {'start Nginx':
  provider => shell,
  command  => 'sudo service nginx start',
  before   => Exec['create first directory'],
}

exec {'create first directory':
  provider => shell,
  command  => 'sudo mkdir -p /data/web_static/releases/test/',
  before   => Exec['create second directory'],
}

exec {'create second directory':
  provider => shell,
  command  => 'sudo mkdir -p /data/web_static/shared/',
  before   => Exec['content into html'],
}

exec {'content into html':
  provider => shell,
  command  => 'echo "Holberton School" | sudo tee /data/web_static/releases/test/index.html',
  before   => Exec['symbolic link'],
}

exec {'symbolic link':
  provider => shell,
  command  => 'sudo ln -sf /data/web_static/releases/test/ /data/web_static/current',
  before   => Exec['put location'],
}

exec {'put location':
  provider => shell,
  command  => 'sudo sed -i \'38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t\tautoindex off;\n\t}\n\' /etc/nginx/sites-available/default',
  before   => Exec['restart Nginx'],
}

exec {'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
  before   => File['/data/']
}

file {'/data/':
  ensure  => directory,
  owner   => 'ubuntu',
  group   => 'ubuntu',
  recurse => true,
}
>>>>>>> 9964e2e4593d82ac4324f2ead1a726498d045fa6
