require 'spec_helper'

describe 'cachetool' do

    it { should compile }

    it { should contain_wget__fetch('cachetool_phar') }

    it { should contain_exec('cachetool_set_permissions').that_requires('Archive[cachetool_phar]')  }

    it do
        should contain_file('cachetool_yml').with(
            'path' => '/etc/cachetool.yml',
            'ensure' => 'file',
            'owner' => 'root',
            'group' => 'root',
        )
    end

end
