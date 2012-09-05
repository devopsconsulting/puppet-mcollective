class mcollective($stomp_host='localhost') {
    class {"mcollective::slave":
        stomp_host => $stomp_host
    }
}
