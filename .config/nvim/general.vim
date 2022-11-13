""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

set incsearch " Incremental search view
set magic " behaviour of slash in patterns
set ignorecase " case sensitivity
set smartcase " no ignorecase when using upper case in search pattern

set wrap " wrap long lines
set showbreak=⤥\ \
set so=7 " Set 7 lines to the cursor - when moving vertically using j/k
set nu " Show line numbers
set rnu " Show relative line numbers
set lbr "enable linebreak after 'tw' characters
set list "enable showing whitespaces"
set lcs=tab:›\ ‹,trail:᎑,nbsp:+ "whitespaces symbols"
set shortmess+=c" Don't pass messages to |ins-completion-menu|.

set background=dark " the background color brightness
syntax enable
set termguicolors " use GUI colors for the terminal
set cursorline "highlight the line of the cursor
set hlsearch " Highlight search results
"set autochdir "move to file's directory - disabled for vim-rooter.

set laststatus=2
set hidden " Sets buffers are hidden instead of closed when moved from set autoread " Set to auto read when a file is changed from the outside
set splitbelow splitright " split directions

set mouse=a " enable mouse in all modes

set showcmd " show partial commands on statusline
set ruler "Always show current position
set confirm " start a dialog when a command fails

set clipboard=unnamedplus " using the clipboard as default register
set cmdheight=2 " Give more space for displaying messages.

set backspace=indent,eol,start " backspace behaviour
set tw=500 " number of characters per line (in which it breaks)
set updatetime=300 " shorter delay for improved performance

set smarttab autoindent smartindent expandtab  " <tab> behaviour
set shiftwidth=4 tabstop=8 softtabstop=4 " <tab> widths

set nowritebackup " don't backup before writing
set nobackup " don't backup after writing
set noswapfile " dont write swap files
set ffs=unix,dos,mac " Use Unix as the standard file type

" TODO 08/08/20 13:55 > define folding

set history=500 " Sets how many lines of history VIM has to remember
set wildmenu " Turn on the Wild menu
"set wildignore=*.o,*~,*.pyc " Ignore compiled files

set encoding=UTF-8 " encoding you know

filetype plugin indent on

" commands and functions
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " (useful for handling the permission-denied error)  :W sudo saves the file

"clean extra spaces on save
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.vim :call CleanExtraSpaces()
endif

" add wildignores based on system
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" overwrite DiffOrig to show syntax-highlighting (by forcing filetype)
command! -bar DiffOrig
    \   vnew +set\ buftype=nofile
    \ | let &filetype = getbufvar(0, '&filetype')
    \ | read ++edit #
    \ | 1delete_
    \ | diffthis
    \ | wincmd p
    \ | diffthis

" restore cursor position
autocmd BufReadPost
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gui
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif
