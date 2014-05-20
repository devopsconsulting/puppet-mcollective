define mcollective::channel($stomp_user, $stomp_password) {

    rabbitmq_exchange {"${title}_broadcast@/mcollective":
        user     => $stomp_user,
        password => $stomp_password,
        type     => 'topic',
        ensure   => present,
    }
    rabbitmq_exchange {"${title}_directed@/mcollective":
        user     => $stomp_user,
        password => $stomp_password,
        type     => 'direct',
        ensure   => present,
    }
}
