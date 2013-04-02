
# unfortunately mcollective installs in ruby1.8 gempath.
# if the os is using ruby 1.9 this will make apt fail.
class mcollective::fixgempath {
    if versioncmp($::rubyversion, '1.9') >= 0 {
        file {"/usr/lib/ruby/${::rubyversion}/mcollective":
            ensure => 'link',
            target => '/usr/lib/ruby/1.8/mcollective'
        } ->
        file {"/usr/lib/ruby/${::rubyversion}/mcollective.rb":
            ensure => 'link',
            target => '/usr/lib/ruby/1.8/mcollective.rb'
        }
    }
}