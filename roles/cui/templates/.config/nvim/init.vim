"------------------------------
" Mapping
"------------------------------
noremap Y y$
vnoremap $ $h
onoremap W :execute 'normal! '.v:count1.'W'<Cr>
noremap <silent> <C-l> :<C-u>nohlsearch<Cr>
nnoremap <Cr> A<Cr><Esc>
inoremap <Right> <C-t>
inoremap <Left> <C-d>

" Leader
noremap <space> <Nop>
let mapleader=" "

" FIXME: ft_sqlの関数がマッピングされててSQLファイルで<C-c>の実行が遅い
inoremap <C-l> <Esc>
vnoremap <C-l> <Esc>

inoremap <C-a> <C-o>^
inoremap <C-b> <C-g>u<Left>
inoremap <C-f> <C-g>u<Right>
inoremap <C-e> <C-g>u<End>
inoremap <C-y> <C-r>"
inoremap <C-p> <C-o>gk
inoremap <C-n> <C-o>gj
inoremap <C-k> <Esc>ld$a
inoremap <C-d> <Del>
inoremap <C-h> <Bs>
cnoremap <C-d> <Del>
cnoremap <C-h> <Bs>
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Prevent default
nmap s <Nop>
xmap s <Nop>
nnoremap Q gq

" Pane
nnoremap <C-w>t :<C-u>tabnew<Space>%<Cr>
nnoremap <C-w>w :<C-u>w<Cr>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
for n in range(1, 9)
 execute 'nnoremap <silent> <C-w>'.n ':<C-u>tabnext'.n.'<Cr>'
endfor

"------------------------------
" telescope
"------------------------------
lua require('plugin.telescope')

"------------------------------
" toggleterm
"------------------------------
lua require('plugin.toggleterm')

"------------------------------
" vim-submode
"------------------------------
let g:submode_leave_with_key = 1
call submode#enter_with('bufmove', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('bufmove', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

call submode#enter_with('undo', 'n', '', 'g-', 'g-')
call submode#enter_with('redo', 'n', '', 'g+', 'g+')
call submode#map('undo', 'n', '', '-', 'g-')
call submode#map('redo', 'n', '', '+', 'g+')

"------------------------------
" nvim-lspconfig
"------------------------------
lua require('plugin.nvim-lspconfig')

"------------------------------
" none-ls
"------------------------------
lua require('plugin.none-ls')

"------------------------------
" nvim-hlslens
"------------------------------
lua require('plugin.nvim-hlslens')

"------------------------------
" nvim-cmp
"------------------------------
lua require('plugin.nvim-cmp')
set completeopt=menuone,noinsert,noselect
highlight! default link CmpItemKind CmpItemMenuDefault

"------------------------------
" nvim-surround
"------------------------------
lua require('plugin.nvim-surround')

"------------------------------
" nvim-autopairs
"------------------------------
lua require('plugin.nvim-autopairs')

"------------------------------
" easymotion
"------------------------------
map <C-s> <Plug>(easymotion-prefix)
lua require('plugin.easymotion')

"------------------------------
" which-key
"------------------------------
lua require("which-key").setup()

"------------------------------
" quickrun
"------------------------------
if v:version >= 802
  let g:quickrun_config = {
        \ '_': {
        \     'outputter': 'popup'
        \   }
        \ }
endif
let g:quickrun_no_default_key_mappings = 1

"------------------------
" vim-illuminate
"------------------------
augroup ILLUMINATE_AUGROUP
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END

"------------------------------
" vim-highlightedyank
"------------------------------
let g:highlightedyank_highlight_duration = 500

"------------------------
" treesitter
"------------------------
lua require('plugin.treesitter')

"------------------------
" gitsigns
"------------------------
lua require('gitsigns').setup()

"------------------------
" lualine
"------------------------
lua require('plugin.lualine')

"------------------------
" bufferline
"------------------------
lua require('plugin.bufferline')

"------------------------
" Indent Blankline
"------------------------
lua require('ibl').setup({ indent = { char = '¦' } })

"-----------------------------
" colorscheme
"-----------------------------
colorscheme kanagawa-dragon

"-----------------------------
" Basic
"-----------------------------
set conceallevel=0

" Charcode
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis
set fileformats=unix,dos,mac
lang en_US.UTF-8

" Search
set incsearch
set hlsearch
set nowrapscan
set noignorecase

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab

" History
set noswapfile
set hidden
if has("persistent_undo")
    set undodir=~/.vim/undo/
    set undofile
endif

" Cursor
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
augroup CursorColumn
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorcolumn
augroup END
set wrap
set number
set backspace=indent,eol,start
set list
set listchars=tab:\¦\ ,trail:-,eol:¬
if has('unix')
	let &t_ti .= "\e[1 q"
	let &t_SI .= "\e[5 q"
	let &t_EI .= "\e[1 q"
	let &t_te .= "\e[0 q"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	inoremap <Esc> <Esc>
endif
set virtualedit=block 
set mouse=n
augroup VIMRC_EX
  " Remember cursor
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
