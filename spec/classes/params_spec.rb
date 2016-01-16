require 'spec_helper'

describe 'cachetool::params', :type => :class do

    it { should compile }

    it { should contain_class("cachetool::params") }

    it "should not contain any resources" do
        should have_resource_count(0)
    end

end