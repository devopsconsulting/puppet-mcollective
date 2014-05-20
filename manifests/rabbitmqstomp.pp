class mcollective::rabbitmqstomp($stomp_user="mcollective", $stomp_password="pleasechangeme") {
    include stdlib

    if $::osfamily == "Debian" {
        class{"rabbitmq::repo::apt":}
    }

    class { 'rabbitmq::server':
        port              => '5673',
        delete_guest_user => true,
        config_stomp => true,
    }
    rabbitmq_vhost { '/mcollective':
        ensure => present,
        provider => 'rabbitmqctl',
    }
    rabbitmq_user { $stomp_user :
        admin    => true,
        password => $stomp_password,
        provider => 'rabbitmqctl',
    }
    rabbitmq_user_permissions {"${stomp_user}@/mcollective":
        configure_permission => '.*',
        read_permission      => '.*',
        write_permission     => '.*',
        provider => 'rabbitmqctl',
    }

    $collectives = environment_collectives()
    mcollective::channel { $collectives:
        stomp_user => $stomp_user,
        stomp_password => $stomp_password
    }
    mcollective::channel { "mcollective":
        stomp_user => $stomp_user,
        stomp_password => $stomp_password
    }

    rabbitmq_plugin {'rabbitmq_stomp':
        ensure => present,
        provider => 'rabbitmqplugins',
    }
    rabbitmq_plugin {"amqp_client":
        ensure => present,
        provider => 'rabbitmqplugins',
    }
}
