class mcollective($stomp_host='localhost', $stomp_port=6163, $stomp_user="mcollective", $stomp_password="pleasechangeme") {
    class {"mcollective::slave":
        stomp_host => $stomp_host,
        stomp_port => $stomp_port,
        stomp_user => $stomp_user,
        stomp_password => $stomp_password,
    }
}
