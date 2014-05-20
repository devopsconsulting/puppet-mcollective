module Puppet::Parser::Functions
    newfunction(:environment_collectives_hash,
        :type => :rvalue,
        :doc => "Return a list of available collectives, based on the environments in puppet.conf.
        " ) do |_|
        Puppet::Parser::Functions.autoloader.loadall

        collectives = function_environment_collectives []
        Hash[collectives.collect { |c| [c, {}] }]
    end
end
