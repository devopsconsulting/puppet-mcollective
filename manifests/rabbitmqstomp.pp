class mcollective::rabbitmqstomp {
    class{"rabbitmq::repo::apt":}
    class { 'rabbitmq::server':
      port              => '5673',
      delete_guest_user => true,
      config_stomp => true,
    }
    rabbitmq_user { 'mcollective':
      admin    => true,
      password => '_9_ehoE8ria1',
      provider => 'rabbitmqctl',
    }
    rabbitmq_user_permissions {"mcollective@/":
        configure_permission => '.*',
          read_permission      => '.*',
          write_permission     => '.*',
          provider => 'rabbitmqctl',
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
