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
nnoremap <C-w>t :<C-u>tabnew<Space>%:h<Cr>
nnoremap <C-w>s :<C-u>new<Space>%:h<Cr>
nnoremap <C-w>v :<C-u>vnew<Space>%:h<Cr>
nnoremap <C-w>e :<C-u>e<Space>%:h<Cr>
nnoremap <C-w>w :<C-u>w<Cr>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
for n in range(1, 9)
 execute 'nnoremap <silent> <C-w>'.n ':<C-u>tabnext'.n.'<Cr>'
endfor

:command Vnew :execute 'vnew +setf\ ' . &filetype
:command New :execute 'new +setf\ ' . &filetype
:command Tabnew :execute 'tabnew +setf\ ' . &filetype

"---------------------------
" Matchit
"---------------------------
runtime macros/matchit.vim

"------------------------------
" fzf
"------------------------------
if isdirectory('/opt/homebrew')
  set rtp+=/opt/homebrew/opt/fzf
else
  set rtp+=/usr/local/opt/fzf
endif
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" apply .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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
" asyncomplete.vim
"------------------------------
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
	\ 'name': 'buffer',
	\ 'allowlist': ['*'],
	\ 'blocklist': ['go'],
	\ 'completor': function('asyncomplete#sources#buffer#completor'),
	\ 'config': {
	\    'max_buffer_size': 5000000,
	\  },
	\ }))

if executable('typescript-language-server')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'typescript-language-server',
		\ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
		\ 'whitelist': ['typescript', 'typescriptreact']
		\ })
endif

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:lsp_async_completion = 1

"------------------------------
" lexima
"------------------------------
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

"------------------------------
" typescript-vim
"------------------------------
augroup TYPESCRIPT_VIM
    autocmd!
    autocmd Filetype typescript packadd typescript-vim
    autocmd Filetype typescriptreact packadd typescript-vim
augroup END

"------------------------------
" vim-jsx-pretty
"------------------------------
augroup VIM_JSX_TYPESCRIPT
    autocmd!
    autocmd Filetype typescriptreact packadd vim-jsx-pretty
augroup END

"------------------------
" gitgutter
"------------------------
let g:gitgutter_async = 0
augroup GITGUTTER
	autocmd!
	autocmd BufWritePre * :GitGutter
augroup END

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
    return "?"
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
      return strlen(_) ? '?'._ : ''
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

" History
set noswapfile
set hidden
if has("persistent_undo")
    set undodir=~/.vim/undo/
    set undofile
endif

" Cursor
set cursorline
hi clear CursorLine
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
