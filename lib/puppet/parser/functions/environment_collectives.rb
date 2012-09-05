module Puppet::Parser::Functions
    newfunction(:environment_collectives,
        :type => :rvalue,
        :doc => "Return a list of available collectives, based on the environments in puppet.conf.
        " ) do |_|
        
        config = File.read Puppet.settings[:config]
        sections = config.split("\n").find_all do |line|
            line =~ /\[.*\]/ and not (
            line.include? "[main]" or
            line.include? "[master]" or
            line.include? "[agent]")
        end
        sections.map do |section|
            section.gsub /\[|\]/, ''
        end
    end
end