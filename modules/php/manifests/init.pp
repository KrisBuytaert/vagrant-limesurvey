# Class: php
#
# This module manages PHP
#
class php {

    $phpPackageList = [
        "php",
        "php-devel",
        "php-pear",
        "php-pecl-apc",
        "php-mcrypt",
        "php-mhash",
        "php-mysql",
        "php-xml",
        "php-xmlrpc" ]

    package { $phpPackageList: }

    # use this is you do not like the default php.ini
    #file {
    #    "/etc/php.ini":
    #        source    => "puppet:///modules/php/php.ini",
    #        owner     => "root",
    #        group     => "root",
    #        subscribe => Package["php"];
    #} # file
} # class php

# Class: php::memcached
#
# Installs php-pecl-memcache
#
class php::memcached inherits php {

    package { "php-pecl-memcache": }
} # class php::memcached

# Class php::geshi
#
# GeSHi is Generic Syntax Highlighting
# used for mediawiki module
#
class php::geshi inherits php {
    
    package { "php-geshi": }
} # class php::geshi
