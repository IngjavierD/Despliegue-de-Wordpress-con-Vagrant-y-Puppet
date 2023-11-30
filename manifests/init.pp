# Manifests/init.pp

package { 'apache2':
  ensure => installed,  
}

service { 'apache2':
  ensure => running,  
  enable => true,
}

package { 'php':
  ensure => installed  
}

package { 'php-mysql':
  ensure  => installed,
  notify => Service['apache2']  
}

package { 'libapache2-mod-php':
  ensure  => installed,
  notify => Service['apache2']
}

package { 'mysql-server':
  ensure => installed,
}

service { 'mysql':
  ensure => running,
  enable => true,  
}

exec { 'set root password':
  command => '/usr/bin/mysqladmin -u root password mysqlpassword',
  path    => '/bin:/usr/bin:/sbin:/usr/sbin',
  unless  => '/usr/bin/mysql -u root -pmysqlpassword -e ";"',
}

exec { 'create wordpress db':
  command => '/usr/bin/mysql -u root -pmysqlpassword -e "create database wordpress; CREATE USER \'wordpress\'@\'localhost\' IDENTIFIED BY \'wordpress\'; grant all on wordpress.* to wordpress@localhost;"',
  path    => '/bin:/usr/bin:/sbin:/usr/sbin',
  unless  => '/usr/bin/mysql -u root -pmysqlpassword -e "use wordpress;"',
}

exec { 'download+extract wordpress':
  command => '/usr/bin/wget https://wordpress.org/latest.tar.gz && tar xzf latest.tar.gz && rm latest.tar.gz',
  path    => '/bin:/usr/bin:/sbin:/usr/sbin',
  cwd     => '/var/www/html',
  creates => '/var/www/html/wordpress',  
}

exec { 'copy wp config':
  command => '/bin/cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php',
  path    => '/bin:/usr/bin:/sbin:/usr/sbin',
  cwd     => '/var/www/html/wordpress',
  unless  => '/bin/cat /var/www/html/wordpress/wp-config.php | /bin/grep -q mysqlpassword',  
}

exec { 'update wp config':
  command => '/usr/bin/sed -i "s/database_name_here/wordpress/g; s/username_here/wordpress/g; s/password_here/wordpress/g;" /var/www/html/wordpress/wp-config.php',
  path    => '/bin:/usr/bin:/sbin:/usr/sbin',  
}

file { 'default_conf':
  path   => '/etc/apache2/sites-available/000-default.conf',
  ensure => file,
  content => 'DocumentRoot /var/www/html/wordpress',
}

exec { 'restart_apache': 
  command     => '/usr/sbin/service apache2 restart',  
  refreshonly => true,
  subscribe   => File['default_conf'], 
}