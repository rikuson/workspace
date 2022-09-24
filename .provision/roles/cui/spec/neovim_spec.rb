home_path = Specinfra.backend.run_command('echo $HOME').stdout.strip

# telescope.nvim
describe package('ripgrep') do
  it { should be_installed.by('homebrew') }
end
[
  { 'namespace' => 'nvim-lua', 'name' => 'plenary.nvim'  },
  { 'namespace' => 'nvim-telescope', 'name' => 'telescope.nvim' },
].each do |item|
  describe file("#{home_path}/.local/share/nvim/site/pack/#{item['namespace']}/start/#{item['name']}") do
    it { should be_directory }
  end
end
