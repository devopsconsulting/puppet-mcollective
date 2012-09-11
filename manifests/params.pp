class mcollective::params {
    case $::operatingsystem {
        'RedHat', 'CentOS', 'Fedora': {
            $ruby_stomp_package = "rubygem-stomp"
            $mcollective_libdir = "/usr/libexec/mcollective"
        }
        'Debian', 'Ubuntu': {
            $ruby_stomp_package = "ruby-stomp"
            $mcollective_libdir = "/usr/share/mcollective/plugins"
        }
    }
}
