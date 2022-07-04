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
noremap <C-z> <Nop>
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

"------------------------------
" fzf
"------------------------------
set rtp+=/opt/homebrew/opt/fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <Leader>f :<C-u>GFiles<Cr>
nnoremap <Leader>s :<C-u>GFiles?<Cr>
nnoremap <Leader>b :<C-u>Buffers<Cr>
nnoremap <Leader>t :<C-u>Templates<Cr>
nnoremap <Leader>g :<C-u>Grep<Cr>
nnoremap <Leader>h :<C-u>History<Cr>

"------------------------------
" easymotion
"------------------------------
map <C-s> <Plug>(easymotion-prefix)

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
