puppet-mcollective: install mcollective
=======================================

Include a server into a collective::

    class {"mcollective":
        stomp_host => 'mcollective.stomphost.com',
        stomp_port => 6163,
        stomp_user => "mcollective",
        stomp_password => "pleasechangeme"
    }

Install the mco command line tool::

    class {"mcollective::master":
        stomp_host => 'mcollective.stomphost.com',
        stomp_port => 6163,
        stomp_user => "mcollective",
        stomp_password="pleasechangeme"
    }

Install a rabbitmq stomp server to connect your servers into a collective::
    
    class {"mcollective::rabbitmqstomp":
        stomp_user => "mcollective",
        stomp_password => "pleasechangeme"
    }
