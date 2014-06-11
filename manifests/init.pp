# == Class: me
#
# Adds the a user 'jq' to a server
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { me:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Jeff Quinn <jeff.quinn@gmail.com>
#
# === Copyright
#
# Copyright 2014 Jeff Quinn here, unless otherwise noted.
#
class me {
    user { 'jq':
        ensure      => 'present',
        groups      => 'sudo',
        managehome  => true,
        shell       => '/bin/zsh',
        require     => Package['zsh'],
    }

    #ZSH config

    if defined( Package[$package]) {
      debug("$package already installed")
    } else {
      package { $package: ensure => $ensure }
    }

 #   package { 'zsh': }

    file { '/home/jq/.zsh':
        ensure      => directory,
        owner       => 'jq',
        group       => 'jq',
        require     => User['jq']
    }

    file { '/home/jq/.zsh/git-prompt':
        ensure      => directory,
        owner       => 'jq',
        group       => 'jq',
        require     => File['/home/jq/.zsh'],
    }

    file { '/home/jq/.zsh/git-prompt/gitstatus.py':
        ensure      => 'present',
        owner       => 'jq',
        group       => 'jq',
        source     => 'puppet:///modules/me/gitstatus.py',
        require     => File['/home/jq/.zsh/git-prompt'],
    }

    file { '/home/jq/.zsh/git-prompt/zshrc.sh':
        ensure      => 'present',
        owner       => 'jq',
        group       => 'jq',
        source     => 'puppet:///modules/me/zshrc.sh',
        require     => File['/home/jq/.zsh/git-prompt'],
    }
    file { '/home/jq/.zprofile':
        ensure      => 'present',
        owner       => 'jq',
        group       => 'jq',
        source     => 'puppet:///modules/me/.zprofile',
    }
    file { '/home/jq/.zshrc':
        ensure      => 'present',
        owner       => 'jq',
        group       => 'jq',
        source     => 'puppet:///modules/me/.zshrc',
        require     => User['jq'],
    }

    #Vim config
# file { '/home/jq/.vimrc':
#    ensure      => 'present',
#    owner       => 'jq',
#    group       => 'jq',
#    content     => file('/tmp/puppet/files/jq/.vimrc'),
#    require     => User['jq'],
#}


    #SSH Keys

    file { '/home/jq/.ssh':
        ensure      => directory,
        owner       => 'jq',
        group       => 'jq',
        mode        => '0700',
        require     => User['jq'],
    }

    file { '/home/jq/.ssh/authorized_keys':
        ensure      => 'present',
        owner       => 'jq',
        group       => 'jq',
        mode        => '0600',
        source     => 'puppet:///modules/me/jq',
        require     => User['jq'],
    }
}
