require 'spec_helper'

describe package('bundler') do
  it { should be_installed.by('gem') }
end

describe package('ansible_spec') do
  it { should be_installed.by('gem') }
end
