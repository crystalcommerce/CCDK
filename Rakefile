require 'rubygems'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'ccdk/version'

begin
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new(:spec) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
rescue LoadError
  desc 'RSpec rake task not available'
  task :spec do
    abort 'Install rspec as a gem to run tests.'
  end
end

desc 'Build the ccdk gem'
task :build do
  system 'gem build ccdk.gemspec'
end

desc 'Push the gem to gemcutter'
task :release => :build do
  system "gem push ccdk-#{Ccdk::VERSION}.gem"
end

desc 'Clean up old gems'
task :clean do
  system 'rm *.gem'
end
