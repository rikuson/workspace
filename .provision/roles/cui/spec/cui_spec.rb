require 'spec_helper'

[
  'bat',
  'direnv',
  'ffmpeg',
  'fzf',
  'ghc',
  'git',
  'gnu-sed',
  'grex',
  'hexyl',
  'htop',
  'httpie',
  'imagemagick',
  'jq',
  'jump',
  'lazygit',
  'lsd',
  'neofetch',
  'neovim',
  'nkf',
  'pandoc',
  'pass',
  'pass-otp',
  'pict',
  'pinentry-mac',
  'poppler',
  'qrencode',
  'tmux',
  'w3m',
].each do |item|
  describe package(item) do
    it { should be_installed }
  end
end

[
  'ag',
  'node',
  'npm',
  'psql',
].each do |item|
  describe command("which #{item}") do
    its(:exit_status) { should eq 0 }
  end
end
