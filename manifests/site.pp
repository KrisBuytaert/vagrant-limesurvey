

class repo {


    yumrepo {
        
        "epel":
            descr => "Epel-5",
            baseurl => "http://mirror.eurid.eu/epel/5/i386/",
            enabled => 1,
            gpgcheck => 0;

	

        }

}

class builddeps {

	package {
	"rpm-build":
		ensure => installed;
	"screen":
		ensure => installed;
	}
}
class defaults {

   service { "iptables":
                ensure => "stopped",
                enable => "false";
                }

   include repo
        



}

node lime {
	$contactEmail = "kris.buytaert@inuits.be"
	include repo
	include apache 
	include php


        include maria::repository
        include maria::packages
	
	$lime_mysql_host = 'localhost'
	$lime_mysql_db   = 'limesurvey'
	$lime_mysql_user = 'root'
	$lime_mysql_pw   = ''

	include limesurvey



}







	



