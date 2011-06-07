class vhosts { 


	file {
		"/tmp/vhost":
                	ensure => present;
		
		 "/var/vhosts":
                        owner => root,
                        group => root,
                        mode => 755,
                        ensure => directory;

        	}

}

define vhosts::removed  ( $ip = "*", $port = "80" , $serveradmin = "root@localhost", $documentroot = '' , $servername = 'localhost' , $createroot = 'yes', $serveralias ) {


    	file { "/etc/httpd/vhosts.d/$servername.conf":
		 	ensure => absent,	

  		 	notify => Service["httpd"];
	  	"/var/log/httpd/$servername/":
                        ensure => absent,
    			recurse => true, purge => true, force => true;
                "/var/log/httpd/$servername/access.log":
                        ensure => absent;
                "/var/log/httpd/$servername/error.log":
                        ensure => absent;
	}


   	if $createroot =='yes' {
                # Recurse apparently doesn't work
                  file { "$documentroot":
                       ensure => absent ,
    			purge => true, force => true,
                        recurse => true;
                        }
		}

}



define vhosts::host  ( $ip = "*", $port = "80" , $serveradmin = "root@localhost", $documentroot = '' , $servername = 'localhost' , $createroot = 'yes', $serveralias ) {


    	file { "/etc/httpd/vhosts.d/$servername.conf":
       		 mode    => 0644,
  		 notify => Service["httpd"],
        	 content => template("vhosts/vhost.conf.erb");
		}


	# Create directories here 

	if $createroot == 'yes' {
		# Recurse apparently doesn't work 
		
		exec{"/bin/mkdir -p $documentroot":}
		
			
		
  		file { "$documentroot":
               	  owner => apache,
                  group => apache,
                  ensure => directory ,
                  recurse => true;
        	}

	}		

	file { 
		"/var/log/httpd/$servername/":
			ensure => directory,
			recurse => true,
			owner => apache,
			group => apache;
		"/var/log/httpd/$servername/access.log":
			group => apache,
			owner => apache;
		"/var/log/httpd/$servername/error.log":
			group => apache,
			owner => apache;
	}
}
