# == Class: me
#
# Full description of class me here.
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
        content     => file('/tmp/puppet/files/jq/gitstatus.py'),
        require     => File['/home/jq/.zsh/git-prompt'],
    }

    file { '/home/jq/.zsh/git-prompt/zshrc.sh':
        ensure      => 'present',
        owner       => 'jq',
        group       => 'jq',
        content     => file('/tmp/puppet/files/jq/zshrc.sh'),
        require     => File['/home/jq/.zsh/git-prompt'],
    }

    file { '/home/jq/.ssh':
        ensure      => directory,
        owner       => 'jq',
        group       => 'jq',
        mode        => '0700',
        require     => User['jq'],
    }

    file { '/home/jq/.ssh/authorized_keys':
        ensure      => present,
        owner       => 'jq',
        group       => 'jq',
        mode        => '0600',
        content     => "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAv6pp+db2O743wZcacG6oh9Jums9of9wY/SKJMm0yHGLj1LO0I7CPTXJeweNbKDff/g2CxEHXCurN3h2uK0+icQmvpxm25L4KO98N97UEITFC8KxNQvFK42jT//Y1vkLqfQygn7zpno+NNF0BhHZRM3KfAa7Wduye6v4syhnTSRCPT8YJ2/Dy5bxzJhNj8RBID17oisKnpqtqDzXqpZFnj/wNu/L7LimYya1s1WkBAmv6dD0bbAYL+44dFzVaSyszHQ0SuMFg3KkQYWGliabv6gFNylLAsCWhD5kteXC807mdK/AsfY6K5wXm3fzTB+m7Wbi2nTvH3tmWERmJDErBUw== rsa-key-20080728 \
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC017rZdlT2K0lPRIcsLormuk1nYmxl6oV/5qAviNvYHplGwlfYNnPXnI9HqnEQtgWdSF9c9XToI8F95p+KECEkyfO1f7smzVyR6d/TEL7DtCU1JZYfyFEEc7GFN19mQlUajdWcRCrqUlH41A/s1NTQk78nWEfeRml+M4Hb2qsHog+5FYq0jPVBm03z+PXNOz154OiNr+wE8BsVuzH1nYUynKLTmk9luaMd4nLhngT6PJsSXWpJHiFiJqMH0keEpcvf6GMemFmNb+H+xalB1ULBpTzp01LVMcxBNituDXphQy74Du5NXUOXF8SGzNLwU933gNC0gRdAx8TDGcvTyagr jq@quinnapps",
        require     => User['jq'],
    }


}
