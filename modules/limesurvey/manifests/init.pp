class limesurvey {

	include limesurvey::dependencies
	include limesurvey::package
	include limesurvey::vhost
	
	
	file { "/var/www/limesurvey/htdocs/config.php":
		content => template("limesurvey/config.php.erb");
	}
}
class limesurvey::package {
	package {
		"limesurvey": ensure => present; 
	}
}
class limesurvey::dependencies {
	package { 
		"php-mbstring": ensure => present ;
		"php-adodb": ensure => present ;
	}	
	
}
class limesurvey::vhost {
	
  vhosts::host {"lime":
		ip =>"*",
		port =>  "80",
		servername => "lime",
		documentroot => "/var/www/limesurvey/htdocs/",
  		serveradmin => "root@localhost",
                createroot => "yes",
		serveralias => "",
}

}





