lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'ccdk/version'

Gem::Specification.new do |s|
  s.name        = 'ccdk'
  s.version     = Ccdk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Ryan Burrows"
  s.email       = "rhburrows@crystalcommerce.com"
  s.homepage    = "http://www.crystalcommerce.com"
  s.summary     = "Crystal Commerce's Development Toolkit"
  s.description = <<-DESC
    Ccdk is a set of extensions helpful to development and testing
  DESC

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"

  s.files = File.readlines("Manifest.txt").inject([]) do |files, line|
    files + [line.chomp]
  end
  s.require_path = 'lib'
end
