require 'rspec-puppet/rake_task'

desc "Run specs check on puppet manifests"
RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*/*_spec.rb'
    t.verbose = true
    t.rspec_opts = "--format documentation --color"
end

task :default => :spec