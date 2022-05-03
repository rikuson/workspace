require 'spec_helper'

[
  'ffmpeg',
  'grex',
  'hexyl',
  'htop',
  'imagemagick',
  'jq',
  'neofetch',
  'nkf',
  'pandoc',
  'qrencode',
  'poppler',
  'postgresql',
  'tmux',
  'w3m',
  'gnu-sed',
  'ghc',
  'httpie',
].each do |item|
  describe package(item) do
    it { should be_installed }
  end
end

[
  'ag',
].each do |item|
  describe command("which #{item}") do
    its(:exit_status) { should eq 0 }
  end
end
