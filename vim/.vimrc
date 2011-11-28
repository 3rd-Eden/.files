" Requires for 256 colors in OS X iTerm(2)
set t_Co=256

filetype off

" Pathogen for easy bundle inclusion
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on
:filetype plugin on

" Omni completion
set ofu=syntaxcomplete#Complete

" Auto commands for easier file editing
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType make setlocal noexpandtab
autocmd BufRead,BufNewFile,BufEnter *.json set ft=javascript
autocmd BufRead,BufNewFile,BufEnter *.ejs set ft=html
autocmd BufRead,BufNewFile,BufEnter *.tt2 set ft=tt2html
autocmd BufRead,BufNewFile,BufEnter */templates-3.0/**.html set ft=tt2
autocmd BufWritePre *.{php,py,pl,js,css,html} call StripTrailingWhite()

" Enable syntax highlighting
syntax enable

set nocompatible
set modelines=0

" Tabbing settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set title
set clipboard=unnamed
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set gdefault
set ttyfast
set ruler
set backspace=indent,eol,start

" Status bar
set laststatus=2
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" Line numbers relative to current position
set relativenumber

let mapleader = ","
let g:gist_clip_command = 'pbcopy'

" Default search with \v
nnoremap / /\v
vnoremap / /\v

" Search/Highlight tweaks
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Make leader space clear up highlighting
nnoremap <leader><space> :noh<cr>

nnoremap <tab> %
vnoremap <tab> %

" Wrap column settings
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=85

" Enable mouse in CLI
set mouse=a

" Show list chars
set list

" List invisible chars same as Textmate
set listchars=tab:▸\ ,eol:¬
noremap <leader>i :set list!<CR>

" Make F2 toggle paste indenting with visual feedback
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Make editing the .vimrc easier, with auto re-load on save
autocmd! bufwritepost .vimrc source $MYVIMRC
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

nnoremap j gj
nnoremap k gk
nnoremap <leader>1 yypVr=

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>v V`]

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>v :vs<CR>
nnoremap <leader>h :split<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Disable autoindenting
nnoremap <leader>ni :setl noai nocin nosi inde=<CR>

" map refresh running browser to r
nnoremap <silent><leader>r :RRB<CR>

" Color scheme and highlighting
colorscheme molokai

" TagList shortcuts
map <leader>t :TlistToggle<CR>
let Tlist_Sort_Type = "order"
let Tlist_Use_SingleClick = 1
let Tlist_Show_Menu = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Enable_Fold_Column = 1
let Tlist_Close_On_Select = 0
let Tlist_Use_Right_Window = 0
let Tlist_Process_File_Always=1
let Tlist_Show_One_File=1
let Tlist_Display_Prototype=1
let Tlist_Max_Submenu_Items=50
let Tlist_Max_Tag_Length=30

" Search for diff separater stuff
nnoremap <Leader>fd /^<<<<<<<\\|^=======\\|^>>>>>>><CR>

" Allow swtiching between relative or normal line numbers
function! SwitchNumbering()
  if &number && ! &relativenumber
    set relativenumber
  else
    set number
  endif
endfunction
nmap <leader>nn :call SwitchNumbering()<CR>

" Atttempt to reformat horrible code
function! FixLeCode()
  " replace in  =/==/===/=> without spaces, to wrap it with spaces.
  :%s/\(!\|+\|-\|\.\|=\|<\|>\)\@<!\(=\|==\|===\|=>\)\( \|>\|=\)\@!/ \2 /g
  :g/function/s/ = /=/g

  " place spaces behind the comma:
  " @TODO this will kill any split, explode, or mysql queries you might have
  " :%s/, \@!/, /g

  " No spaces @ EOL
  :%s/\s\+$//g

  " No braces on the next line
  :g/^\s*function .\+)$/j
endfunction

" Create a vim modeline
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("^"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Remove whitespace from code files on save
function! StripTrailingWhite()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction

" Markdown
augroup mkd
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

" Move temporary files to ~/.vimtmp/ instead of current dir
if ! isdirectory(expand('~/.vimtmp'))
  call mkdir(expand('~/.vimtmp'))
endif

if isdirectory(expand('~/.vimtmp'))
  set directory=~/.vimtmp
else
  set directory=.,/var/tmp,/tmp
endif

" Set history and undo
set history=1000
set undolevels=1000

" Setup persistently store the undo folder
if ! isdirectory(expand('~/.vimundo'))
  call mkdir(expand('~/.vimundo'))
endif

" Set persistent undo
set undodir=~/.vimundo
set undofile

" Dedicated settings for when a GUI is running
if has('gui_running')
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  set guioptions-=L
  hi ColorColumn ctermbg=darkgrey guibg=#232526
  hi SpecialKey guifg=#444444
  hi NonText guifg=#444444 guibg=bg
  hi Todo gui=undercurl
endif

if has('gui_macvim')
  behave xterm
  set selectmode=
  set keymodel=
  set mousemodel=popup_setpos
endif

syntax on
