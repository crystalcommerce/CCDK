require 'erb'

module Ccdk #:nodoc:

  # Create a templated representation of the object. This module can be useful
  # For debugging objects by dumping them out to a template of your choosing.
  # Similar in use to <tt>pp</tt>, but more flexible so that you can display
  # only the information that you care about.
  module TDump

    # Convert the object to a <tt>String</tt> based on the provided template.
    # Templates can be specified in several ways
    #
    # * A <tt>String</tt> representation of the template.
    # * A <tt>String</tt> path to a template file
    # * An <tt>Erb</tt> object of the template
    # * An <tt>IO<tt> object that can be read to retrieve a template
    #   (Really anything that responds to <tt>#read</tt>)
    #
    # ==== Parameters
    #
    # * +template+ - The template to use for formatting the object
    #
    # ==== Examples
    #   # Output information to a templating string
    #   car.tdump('I have a <%= year %> <%= make %> <%= model %>')
    #
    #   # Use the path to an erb template file
    #   product.tdump('path/to/product_template.erb')
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
