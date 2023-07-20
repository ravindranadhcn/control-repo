class users {
    include users::groups
    user {'newuser':
           ensure => present,
           home => '/home/newuser',
           shell =>  '/bin/sh',
           managehome => true,
           gid => 'puppetusers',
           password => 'test'}
}