"------------------------------
" Mapping
"------------------------------
noremap Y y$
vnoremap $ $h
onoremap W :execute 'normal! '.v:count1.'W'<Cr>
inoremap <C-j> <C-o>o
inoremap <M-j> <C-o>O
noremap <silent> <C-l> :<C-u>nohlsearch<Cr>
nnoremap <Cr> A<Cr><Esc>
inoremap <Right> <C-t>
inoremap <Left> <C-d>
" nnoremap <C-[> <C-]>

" Leader
noremap <space> <Nop>
let mapleader=" "

" FIXME: ft_sqlの関数がマッピングされててSQLファイルで<C-c>の実行が遅い
inoremap <C-l> <Esc>
vnoremap <C-l> <Esc>

" Emacs Like
if has('mac')
	set <M-b>=∫
	set <M-f>=ƒ
	set <M-v>=√
else
	set <M-b>=b
	set <M-f>=f
	set <M-v>=v
	set <M-j>=j
endif
inoremap <C-a> <C-o>^
inoremap <C-b> <C-g>u<Left>
inoremap <M-b> <C-o>b
inoremap <C-f> <C-g>u<Right>
inoremap <M-f> <C-o>e<Right>
inoremap <C-e> <C-g>u<End>
inoremap <C-y> <C-r>"
" inoremap <C-v> <C-o><C-f>
inoremap <M-v> <C-o><C-b>
inoremap <C-p> <C-o>gk
inoremap <C-n> <C-o>gj
inoremap <C-k> <Esc>ld$a
inoremap <C-d> <Del>
inoremap <C-h> <Bs>
inoremap <M-w> <C-o>de
" inoremap <C-u> <C-g>u<C-u>
" inoremap <C-w> <C-g>u<C-w>
" inoremap <C-x><C-s> <C-o>:w<Cr>
" inoremap <C-x><C-w> <C-o>:w
" inoremap <C-x>u <C-o>u
" inoremap <C-x><C-r> <C-o><C-r>
cnoremap <C-d> <Del>
cnoremap <C-h> <Bs>
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Prevent default
noremap <C-z> <Nop>
nmap s <Nop>
xmap s <Nop>
nnoremap Q gq

" Pane
nnoremap <C-w>t :<C-u>tabnew<Space>%:h<Cr>
nnoremap <C-w>s :<C-u>new<Space>%:h<Cr>
nnoremap <C-w>v :<C-u>vnew<Space>%:h<Cr>
nnoremap <C-w>e :<C-u>e<Space>%:h<Cr>
" nnoremap <C-w>o :<C-u>tabo<Cr>:only<Cr>
nnoremap <C-w>w :<C-u>w<Cr>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
for n in range(1, 9)
 execute 'nnoremap <silent> <C-w>'.n ':<C-u>tabnext'.n.'<Cr>'
endfor

:command Vnew :execute 'vnew +setf\ ' . &filetype
:command New :execute 'new +setf\ ' . &filetype
:command Tabnew :execute 'tabnew +setf\ ' . &filetype

"-----------------------------
" My Function
"-----------------------------
function! s:search(pat)
	let l:cache = []
	execute '%s/' . a:pat . '/\=add(l:cache, submatch(0))/n'
	call setreg(v:register,join(l:cache, "\n"))
endfunction
command! -nargs=* SearchYank call s:search(<q-args>)

"---------------------------
" vim-plug
"---------------------------
call plug#begin('~/.vim/bundle')

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Input Method
" Plug 'tpope/vim-repeat'
Plug 'cohama/lexima.vim'
Plug 'easymotion/vim-easymotion'
Plug 'kana/vim-operator-user'
	Plug 'kana/vim-operator-replace'
Plug 'machakann/vim-sandwich'
Plug 'mg979/vim-visual-multi'
" Plug 'osyo-manga/vim-operator-stay-cursor' FIXME: Can not yank to clipboard with this
Plug 'thinca/vim-submode'
Plug 'vim-scripts/sketch.vim'
Plug 'zef/vim-cycle'
Plug 'tyru/caw.vim'

" UI
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'w0ng/vim-hybrid'
Plug 'ryanoasis/vim-devicons'
Plug 'RRethy/vim-illuminate'
Plug 'machakann/vim-highlightedyank'

" Filer
Plug 'cocopon/vaffle.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'mattesgroeger/vim-bookmarks'
" TODO: Undoとのdiffがほしい
Plug 'mbbill/undotree'

" Completion
Plug 'mattn/sonictemplate-vim'
Plug 'zxqfl/tabnine-vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete-buffer.vim'
" Plug 'mattn/vim-lsp-settings'
" Plug 'imomaliev/registers.vim' FIXME: conflicts with AutoCompletion

" Pane
Plug 'regedarek/ZoomWin'
Plug 'thaerkh/vim-workspace'

" Lang
Plug 'sheerun/vim-polyglot', { 'on': [] }

" Debug
Plug 'thinca/vim-quickrun'
Plug 'w0rp/ale'
Plug 'pechorin/any-jump.vim', { 'on': [] }
Plug 'puremourning/vimspector'
Plug 'preservim/tagbar'

" Utility
Plug 'vim-scripts/sudo.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-abolish'
" Plug 'junegunn/vim-peekaboo' FIXME: changes cursor position by pasting

call plug#end()

"---------------------------
" Matchit
"---------------------------
runtime macros/matchit.vim

"------------------------------
" any-jump
"------------------------------
if v:version >= 802
  call plug#load('any-jump.vim')
endif
let g:any_jump_disable_default_keybindings = 1
nnoremap <Tab> :AnyJump<CR>
xnoremap <Tab> :AnyJumpVisual<CR>

"------------------------------
" vim-polyglot
"------------------------------
let g:polyglot_disabled = ['javascript']
call plug#load('vim-polyglot')

"------------------------------
" tagbar
"------------------------------
nmap <F8> :TagbarToggle<CR>
let g:tagbar_left = 1

"------------------------------
" undotree
"------------------------------
nmap <F3> :UndotreeToggle<CR>
let g:tagbar_left = 1

"------------------------------
" caw
"------------------------------
nmap \ <Plug>(caw:prefix)
nmap \\ <Plug>(caw:hatpos:toggle)

" "------------------------------
" " asyncomplete
" "------------------------------
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
" 
" call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
"     \ 'name': 'buffer',
"     \ 'allowlist': ['*'],
"     \ 'blocklist': ['go'],
"     \ 'completor': function('asyncomplete#sources#buffer#completor'),
"     \ 'config': {
"     \    'max_buffer_size': 5000000,
"     \  },
"     \ }))
" 
" "------------------------------
" " vim-lsp
" "------------------------------
" let g:lsp_diagnostics_enabled = 0

"------------------------------
" vim-workspace
"------------------------------
nnoremap <Leader>s :<C-u>ToggleWorkspace<Cr>

"------------------------------
" vim-highlightedyank
"------------------------------
let g:highlightedyank_highlight_duration = 500

"------------------------------
" vim-operator-replace
"------------------------------
map R <Plug>(operator-replace)

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

"------------------------------
" fzf
"------------------------------
" nnoremap <Space> :<C-u>FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" apply .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ファイル一覧を出すときにプレビュー表示
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang Templates
      \ call fzf#sonictemplate#run()

nnoremap <Leader>f :<C-u>GFiles<Cr>
nnoremap <Leader>s :<C-u>GFiles?<Cr>
nnoremap <Leader>b :<C-u>Buffers<Cr>
nnoremap <Leader>t :<C-u>Templates<Cr>
nnoremap <Leader>g :<C-u>Grep<Cr>
nnoremap <Leader>h :<C-u>History<Cr>

function! Fzf_dev()
  function! s:files()
    let files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(files)
  endfunction

  function! s:prepend_icon(candidates)
    let result = []
    for candidate in a:candidates
      let filename = fnamemodify(candidate, ':p:t')
      let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
      call add(result, printf("%s %s", icon, candidate))
    endfor

    return result
  endfunction

  function! s:edit_file(item)
    let parts = split(a:item, ' ')
    let file_path = get(parts, 1, '')
    execute 'silent e' file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m -x +s',
        \ 'down':    '40%' })
endfunction

"------------------------------
" ALE
"------------------------------
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'markdown': ['textlint'],
\}
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'css': ['prettier'],
      \ 'php': ['php_cs_fixer'],
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_lint_on_text_changed = 0
let g:ale_markdown_prettier_options = ''
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass

"------------------------------
" vimspector
"------------------------------
" let g:vimspector_enable_mappings = 'HUMAN'

"------------------------------
" sonictemplate
"------------------------------
" FIXME: <を入力するともっさりする
let g:sonictemplate_vim_template_dir = ['$HOME/.vim/template']
let g:sonictemplate_key = '<Nop>'
let g:sonictemplate_intelligent_key = '<Nop>'

"------------------------------
" Vaffle
"------------------------------
function! VaffleRenderCustomIcon(item)
  return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
endfunction

let g:vaffle_render_custom_icon = 'VaffleRenderCustomIcon'

"------------------------------
" sandwich
"------------------------------
runtime macros/sandwich/keymap/surround.vim
let g:sandwich_no_default_key_mappings = 1
map s <Plug>(operator-sandwich-add)
map S v$s

let g:sandwich#recipes += [
			\   {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1,
			\    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
			\
			\   {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1,
			\    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
			\
			\   {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1,
			\    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
			\
			\   {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1,
			\    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
			\    'action': ['delete'], 'input': ['{']},
			\
			\   {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1,
			\    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
			\    'action': ['delete'], 'input': ['[']},
			\
			\   {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1,
			\    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
			\    'action': ['delete'], 'input': ['(']},
			\ ]
let g:sandwich#recipes += [
			\   {
			\     'buns'    : ['/*', '*/'],
			\     'kind'    : ['add'],
			\     'action'  : ['add'],
			\     'input'   : ['\'],
			\     'filetype': ['javascript', 'php']
			\   },
			\ ]
let g:sandwich#recipes += [
			\   {
			\     'buns'    : ['<!--', '-->'],
			\     'kind'    : ['add'],
			\     'action'  : ['add'],
			\     'input'   : ['\'],
			\     'filetype': ['html', 'markdown']
			\   },
			\ ]

"------------------------------
" easymotion
"------------------------------
map <C-s> <Plug>(easymotion-prefix)

"------------------------------
" vim-json
"------------------------------
" indentLineによってJSONのダブルクォーテーションが表示されない問題の対応
"------------------------------
let g:vim_json_syntax_conceal = 0

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

" call submode#enter_with('pane', 'n', '', '<C-w>n', 'gt')
" call submode#enter_with('pane', 'n', '', '<C-w>p', 'gT')
" call submode#enter_with('pane', 'n', '', '<C-w>h', '<C-w>h')
" call submode#enter_with('pane', 'n', '', '<C-w>j', '<C-w>j')
" call submode#enter_with('pane', 'n', '', '<C-w>k', '<C-w>k')
" call submode#enter_with('pane', 'n', '', '<C-w>l', '<C-w>l')
" call submode#map('pane', 'n', '', 'n', 'gt')
" call submode#map('pane', 'n', '', 'p', 'gT')
" call submode#map('pane', 'n', '', 'h', '<C-w>h')
" call submode#map('pane', 'n', '', 'j', '<C-w>j')
" call submode#map('pane', 'n', '', 'k', '<C-w>k')
" call submode#map('pane', 'n', '', 'l', '<C-w>l')

"------------------------------
" lexima
"------------------------------
" inoremap <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

" HTMLタグ補完
call lexima#add_rule({
			\   'at': '<[^>\|\/]\+\%#',
			\   'char': '>',
			\   'input': '></<C-x><C-o><Esc>%i',
			\   'filetype': ['html'],
			\ })
call lexima#add_rule({
			\   'at': '<[^>\|\/]\+>\%#<\/[^>]\+>',
			\   'char': '<Cr>',
			\   'input': '<Cr><C-o>O',
			\   'filetype': ['html'],
			\ })
call lexima#add_rule({
			\   'at': '^- .*\%#',
			\   'char': '<Cr>',
			\   'input': '<Cr>- ',
			\   'filetype': ['markdown'],
			\ })
call lexima#add_rule({
			\   'at': '^> .*\%#',
			\   'char': '<Cr>',
			\   'input': '<Cr>> ',
			\   'filetype': ['markdown'],
			\ })

"------------------------------
" vim-bookmarks
"------------------------------
let g:bookmark_sign = ''

"------------------------
" gitgutter
"------------------------
let g:gitgutter_async = 0
augroup GITGUTTER
	autocmd!
	autocmd BufWritePre * :GitGutter
augroup END

"------------------------
" lightline
"------------------------
set noshowmode
set showtabline=2
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [
			\     ['paste'],
			\     ['fugitive', 'gitgutter', 'filename'],
			\   ],
			\   'right': [
			\     ['lineinfo'],
			\     ['percent'],
			\     ['fileformat', 'fileencoding'],
			\   ]
			\ },
			\ 'component_function': {
			\   'modified': 'MyModified',
			\   'readonly': 'MyReadonly',
			\   'fugitive': 'MyFugitive',
			\   'filename': 'MyFilename',
			\   'fileformat': 'MyFileformat',
			\   'fileencoding': 'MyFileencoding',
      \   'gitgutter': 'MyGitGutter' },
			\ 'separator': {'left': '', 'right': ''},
			\ 'subseparator': {'left': '', 'right': '|'},
			\ 'tab': {
			\   'active': ['tabnum', 'filename', 'modified'],
			\   'inactive': ['tabnum', 'filename', 'modified'] },
      \ 'tab_component_function': {
      \   'filename': 'lightline#tab#filename',
      \   'modified': 'lightline#tab#modified',
      \   'readonly': 'lightline#tab#readonly',
      \   'tabnum': 'lightline#tab#tabnum' }
			\ }

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! MyFileType()
  return &filetype ==# 'vaffle' ? g:DevIconsDefaultFolderOpenSymbol : WebDevIconsGetFileTypeSymbol()
endfunction

function! MyFilename()
	return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
				\ (strlen(&filetype) ? MyFileType() . ' ' : '') .
				\  (&ft == 'vaffle' ? substitute(expand('%:p'),'vaffle://[0-9]\+/'.getcwd(),'','') :
				\ '' != expand('%:p') ? substitute(expand('%:p'),getcwd().'/','','') : '[No Name]')
endfunction

" fugitiveのコマンドを実行するまでアイコンが表示されない
function! MyFugitive()
  try
    if exists("*fugitive#head")
      let _ = fugitive#head()
      return strlen(_) ? ''._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFileencoding()
	return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyGitGutter()
	if ! exists('*GitGutterGetHunkSummary')
				\ || ! get(g:, 'gitgutter_enabled', 0)
				\ || winwidth('.') <= 90
		return ''
	endif
	let symbols = [
				\ g:gitgutter_sign_added . ' ',
				\ g:gitgutter_sign_modified . ' ',
				\ g:gitgutter_sign_removed . ' '
				\ ]
	let hunks = GitGutterGetHunkSummary()
	let ret = []
	for i in [0, 1, 2]
		if hunks[i] > 0
			call add(ret, symbols[i] . hunks[i])
		endif
	endfor
	return join(ret, ' ')
endfunction

"------------------------
" vim-illuminate
"------------------------
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END

"-----------------------------
" Sketch
"-----------------------------
" FIXME
" call ToggleSketch()

"-----------------------------
" Hybrid
"-----------------------------
set background=dark
colorscheme hybrid

"-----------------------------
" Basic
"-----------------------------
" Charcode
set encoding=utf-8
scriptencoding utf-8
set charconvert=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis
set fileformats=unix,dos,mac
" set ambiwidth=double " NOTE: Conflict with vimspector

" Search
set incsearch " 逐語検索
set hlsearch " 検索結果強調:nohで解除
set nowrapscan " 折り返し検索をしない
set noignorecase " 大文字小文字の区別

" Indentation
set autoindent
set tabstop=2
set shiftwidth=2

" Indent by TAB if the buffer includes TAB
augroup INDENTING
	autocmd!
	autocmd BufEnter * call MyIndent()
augroup END
function! MyIndent()
	if search('^\t') > search('^\s')
		set noexpandtab
	else
		set expandtab
	endif
endfunction

" Folding
set fdc=0
set fdo-=search
set fdo-=hor
set foldtext=MyFoldText()
function! MyFoldText()
	let l:num = v:foldend-v:foldstart+1.' lines:'
	let l:indent = ''
	let l:index = 1
	while l:index <= indent(v:foldstart)
		let l:indent .= '-'
		let l:index += 1
	endwhile
	let l:marker = split(&foldmarker, ',')
	let l:commentstring = split(&commentstring, '%s')
	let l:escape = ['\s','*','\/', '-', '='] + l:marker + l:commentstring
	let l:escapereg = '\('.join(l:escape, '\|').'\)\+'
	let l:reg = '\(^'.l:escapereg.'\|'.l:escapereg.'$\)'
	let l:quote = substitute(join(getline(v:foldstart, v:foldstart+1), ' '), l:reg, '', 'g')
	return l:indent.'+-- '.join([l:num, l:quote], ' ').' '
endfunction

" History
set noswapfile
set hidden
if has("persistent_undo")
    set undodir=~/.vim/undo/
    set undofile
endif

" Dictionary
" augroup DICTIONARIES
" 	autocmd!
" 	autocmd Filetype php setlocal dictionary=~/.vim/dict/php.dict
" 	autocmd Filetype javascript setlocal dictionary=~/.vim/dict/javascript.dict
" augroup END

" Ctags
set tags=./tags;
augroup CTAGS
	" autocmd BufWritePost * call system('ag -l | ctags --links=no -L-')
augroup END

" Diff
if has("patch-8.1.0360")
  set diffopt+=internal,algorithm:patience
endif

" Completion
set completeopt-=preview

" Command Completion
set wildmenu
set wildmode=full,full
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*

" Status Line
set laststatus=2
set showcmd

" Cursor
set cursorline
hi clear CursorLine
set wrap
set number
" set relativenumber
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
