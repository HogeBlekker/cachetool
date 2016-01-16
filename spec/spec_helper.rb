require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
    c.before do
        # avoid "Only root can execute commands as other users"
        Puppet.features.stubs(:root? => true)
    end
    c.module_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    c.manifest_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..','..','manifests'))
end

RSpec.configure do |c|
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end