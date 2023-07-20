class users::groups {
    group {'puppetusers':
           ensure => present,
           }
}