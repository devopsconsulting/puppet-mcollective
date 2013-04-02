class mcollective::slave($stomp_host='localhost', $stomp_port=6163,
$stomp_user="mcollective", $stomp_password="pleasechangeme"
) inherits mcollective::params {
    
    # make sure symlinks to mcollective in ruby1.8 are in place
    # before installation of mcollective, because apt will
    # crash otherwise.
    class {"mcollective::fixgempath":} -> Class['mcollective::slave']
    
    package{$ruby_stomp_package: ensure => latest } ->
    package{"mcollective-common": ensure => latest} ->
    
    package {"mcollective":
        ensure => latest,
        require => File["/etc/mcollective/server.cfg"],
    } ->
    package {[  "mcollective-plugins-puppetd",
                "mcollective-plugins-service",
                "mcollective-plugins-package",
                "mcollective-plugins-cleanup"]:
        ensure => latest,
        require => Package["mcollective"]
    }
    
    # very strange that a standard package requires renaming of file to activate but whatever.
    exec {"activate-service":
        command => "/bin/mv $mcollective_libdir/mcollective/agent/puppet-service.rb $mcollective_libdir/mcollective/agent/service.rb",
        creates => "$mcollective_libdir/mcollective/agent/service.rb",
        require => Package["mcollective-plugins-service"],
        notify => Service["mcollective"],
    }

    exec {"activate-package":
        command => "/bin/mv $mcollective_libdir/mcollective/agent/puppet-package.rb $mcollective_libdir/mcollective/agent/package.rb",
        creates => "$mcollective_libdir/mcollective/agent/package.rb",
        require => Package["mcollective-plugins-package"],
        notify => Service["mcollective"],
    }
    
    file {"/etc/mcollective/server.cfg":
        content => template("mcollective/server.cfg.erb"),
        replace => true,
        require => Package['mcollective-common'],
        mode => '0640',
        owner => 'root',
        group => 'root',
        notify => Service['mcollective'],
    }

    file{"/etc/mcollective/facts.yaml":
        owner    => root,
        group    => root,
        mode     => '0400',
        loglevel => debug,  # this is needed to avoid it being logged and reported on every run
        # avoid including highly-dynamic facts as they will cause unnecessary template writes
        content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.to_yaml %>")
    }
    
    service {"mcollective":
        ensure => running,
        hasrestart => true,
        hasstatus => true,
        enable => true,
        require => [File["/etc/mcollective/server.cfg"], Package["mcollective"]]
    }
}
