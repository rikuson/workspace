require 'spec_helper'

describe package('bundler') do
  it { should be_installed.by('gem').with_version('1.17.2') }
end
