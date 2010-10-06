require 'zlib'

module Ccdk #:nodoc:

  # A class for reading Rails log files. Provides a way to step through the log
  # by assuming the format of the output conforms to the Rails defaul.
  class LogFile

    class << self

      # Open a LogFile with the provided name. If the file name ends in '.gz'
      # assume that the file is gzipped
      #
      # ==== Parameters
      #
      # * +file_name+ - The name of the log file to open
      #
      # ==== Examples
      #   # Open the log file 'log/production.log'
      #   LogFile.open('log/production.log')
      #
      #   # Open the gzipped log file 'log/old/production.log.1.gz'
      #   LogFile.open('log/old/production.log.1.gz')
      def open(file_name)
        if file_name =~ /\.gz$/
          GzipLogFile.new(file_name)
        else
          LogFile.new(file_name)
        end
      end
    end

    # Create a new LogFile
    #
    # ==== Parameters
    #
    # * +name+ - The name of the file to open
    def initialize(name)
      @fh = File.open(name, 'r')
    end

    # execute code on each block of the log file. A block is defined as starting
    # with Processing and ending with a blank line
    #
    # ==== Examples
    #   log.each_block{ |b| puts b if b =~ ApplicationController }
    def each_block
      while !@fh.eof?
        yield next_block
      end
    end

    # Read the next block from the log file
    #
    # TODO: please refactor me
    def next_block
      lines = []

      line = @fh.gets
      while !start_of_block?(line)
        line = @fh.gets
        return "" if @fh.eof?
      end

      while(!@fh.eof? && !end_of_block?(line))
        lines << line.chomp
        line = @fh.gets
      end

      lines.join("\n")
    end

    # Close the log file
    def close
      @fh.close
    end

    private

    def start_of_block?(line)
      line && line =~ /^Processing/
    end

    def end_of_block?(line)
      line.nil? || line =~ /^$/
    end
  end

  # A Gzipped version of the log file
  # All behavior is the same as a standard log file except it assumes the
  # content has been gzipped
  class GzipLogFile < LogFile

    # Create a new GzipLogFile. The file name passed must be gzipped
    #
    # ==== Parameters
    #
    # * +file_name+ - The name of the gzipped log file to open
    def initialize(file_name)
      @fh = Zlib::GzipReader.new(File.open(file_name, 'r'))
    end
  end
end
