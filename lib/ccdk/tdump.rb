require 'erb'

module Ccdk
  module TDump
    def tdump(template)
      if template.is_a? ERB
        tdump_erb(template)
      elsif template.respond_to?(:read)
        tdump_io(template)
      elsif template.is_a? String
        tdump_string(template)
      end
    end

    private

    def tdump_erb(erb)
      erb.result(binding)
    end

    def tdump_string(string)
      if File.exist?(string)
        tdump_erb(ERB.new(File.read(string)))
      else
        tdump_erb(ERB.new(string))
      end
    end

    def tdump_io(io)
      tdump_erb(ERB.new(io.read))
    end
  end
end

class Object
  include Ccdk::TDump
end
