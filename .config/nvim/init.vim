" _   ________  ___  _____          ____                    __  _
"| | / /  _/  |/  / / ___/__  ___  / _(_)__ ___ _________ _/ /_(_)__  ___
"| |/ // // /|_/ / / /__/ _ \/ _ \/ _/ / _ `/ // / __/ _ `/ __/ / _ \/ _ \
"|___/___/_/  /_/  \___/\___/_//_/_//_/\_, /\_,_/_/  \_,_/\__/_/\___/_//_/
"                                     /___/
"
" ________________________  __ _____    ________________________
"/___/___/___/___/___/___/ / // / _ \  /___/___/___/___/___/___/
"           /___/___/___/  \_, / .__/ /___/___/___/
"                         /___/_/

" Source other files
source $XDG_CONFIG_HOME/nvim/plugin-conf.vim
source $XDG_CONFIG_HOME/nvim/filetype-conf.vim

" TODO 15/08/20 23:59 > replace ctrlp - FZF is much better :)

" Use preset argument to open it
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
set list "enable shoing whitespaces"
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

"source init after each save
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

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

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" helper for visualselection
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

" handle visual selection search operations
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" delete until a slash in cmd
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"key-bindings
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let mapleader=","

" Run command under cursor in shell
nnoremap Q !!sh<CR>

" plugin bindings
nnoremap <leader>g :Goyo<CR>
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>
nmap <leader>/ <plug>NERDCommenterToggle
vmap <leader>/ <plug>NERDCommenterToggle
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Explorer
nmap <space>fl :CocCommand explorer --preset floatingRightside<CR>
nmap <space>fe :CocCommand explorer --preset .init<CR>
nmap <space>ff :CocCommand explorer<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Mappings for CoCList
" Manage extensions.
nnoremap <silent><nowait> <space>x  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" md preview
nmap <leader>mm :MarkdownPreview<cr>
nmap <leader>ms :MarkdownPreviewStop<cr>

" splits
nnoremap <leader>sh :sf
nnoremap <leader>ss :vert sf

" resize window
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" navigating windows
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" saving
nmap <leader>ww :w<cr>
nmap <leader>ws :W<cr>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
" turn off highlight-searching
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>bq :bd<cr>
" Close all the buffers
map <leader>ba :bufdo bd<cr>
map <leader>bl :bnext<cr>
map <leader>bh :bprevious<cr>
map <leader>bo :BufOnly<cr>
"show buffers
nmap <leader>bb :Buffers<cr>
" tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tf  :tabfind<Space>
nnoremap tq  :tabclose<CR>

" Move a line of text using leader+[-=]
nmap - mz:m+<cr>`z
nmap + mz:m-2<cr>`z
vmap - :m'>+<cr>`<my`>mzgv`yo`z
vmap + :m'<-2<cr>`>my`<mzgv`yo`z

" Quickly open a buffer for scribble
map <leader>q :VimwikiIndex<space>
" Quickly open a markdown buffer for scribble
map <leader>x :e ~/Documents/.md-buffer.md<cr>
" Quickly load config
map <leader>e :e! $XDG_CONFIG_HOME/nvim/init.vim<cr>
" Quick resourcing of the init
"nnoremap <C-s> :source $XDG_CONFIG_HOME/nvim/init.vim<CR>
nmap <m-s> <Plug>MarkdownPreview
nmap <space>m <Plug>MarkdownPreviewToggle

" easier exit from insert mode
imap jk <esc>
"create shell buffer
nmap <leader>r :bo 15sp +te<cr>

"mappings for quick change of colorschemes
map <F1> :colorscheme gruvbox<CR>
map <F2> :colorscheme base16-onedark<CR>
map <F3> :colorscheme base16-default-dark<CR>
map <F4> :colorscheme base16-tomorrow-night-eighties<CR>
map <F5> :colorscheme base16-railscasts<CR>
map <F6> :colorscheme molokai<CR>
map <F7> :colorscheme zenburn<CR>
map <F8> :colorscheme tender<CR>

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Documents/
cno $j e ~/Downloads/
cno $c e <C-\>eCurrentFileDir("e")<cr>
" it deletes everything until the last slash
cno $/ <C-\>eDeleteTillSlash()<cr>

" abbreviations
iab xdt <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%d/%m/%y")<cr>
iab xtime <c-r>=strftime("%H:%M:%S")<cr>

" sort alphabettically
vnoremap <leader>s :sort<cr>

" indentation w/o losing selectoin
vnoremap < <gv

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

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

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"map <F5> :colorscheme spacegray<CR>

"Color Settings
colorscheme gruvbox

"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE guifg=NONE  ctermfg=NONE
hi Search guibg=wheat guifg=purple
