class mcollective::master($stomp_host='localhost', $stomp_port=6163, $stomp_user="mcollective", $stomp_password="pleasechangeme") {
    
    package {["mcollective-client"]:
        ensure => latest,
        require => [Class["mcollective::slave"], Class["mcollective::rabbitmqstomp"]],
    }
    
    $collectives = environment_collectives()
    file {"/etc/mcollective/client.cfg":
        content => template("mcollective/client.cfg.erb"),
        replace => true,
        require => Package['mcollective-common'],
        mode => '0644',
        owner => 'root',
        group => 'root'
    }
}
