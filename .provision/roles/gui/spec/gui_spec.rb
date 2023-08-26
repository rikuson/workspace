require 'spec_helper'

[
  'clipy',
  'docker',
  'drawio',
  'dynalist',
  'font-fira-code-nerd-font',
  'google-chrome',
  'rectangle',
  'typora',
].each do |item|
  describe command("brew info #{item}") do
    its(:exit_status) { should eq 0 }
  end
end
