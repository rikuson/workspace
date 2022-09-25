home_path = Specinfra.backend.run_command('echo $HOME').stdout.strip

# vaffle.vim
[
  { 'namespace' => 'cocopon', 'name' => 'vaffle.vim' },
  { 'namespace' => 'ryanoasis', 'name' => 'vim-devicons' },
].each do |item|
  describe file("#{home_path}/.local/share/nvim/site/pack/#{item['namespace']}/start/#{item['name']}") do
    it { should be_directory }
  end
end

# lightline.vim
[
  { 'namespace' => 'itchyny', 'name' => 'lightline.vim' },
  { 'namespace' => 'ryanoasis', 'name' => 'vim-devicons' },
].each do |item|
  describe file("#{home_path}/.local/share/nvim/site/pack/#{item['namespace']}/start/#{item['name']}") do
    it { should be_directory }
  end
end

# telescope.nvim
describe package('ripgrep') do
  it { should be_installed.by('homebrew') }
end
[
  { 'namespace' => 'kyazdani42', 'name' => 'nvim-web-devicons' },
  { 'namespace' => 'nvim-lua', 'name' => 'plenary.nvim'  },
  { 'namespace' => 'nvim-telescope', 'name' => 'telescope.nvim' },
].each do |item|
  describe file("#{home_path}/.local/share/nvim/site/pack/#{item['namespace']}/start/#{item['name']}") do
    it { should be_directory }
  end
end
