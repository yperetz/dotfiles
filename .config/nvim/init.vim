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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO 15/08/20 23:59 > replace ctrlp - FZF is much better :)
call plug#begin('~/.config/nvim/plugged')
"tools
    Plug 'Xuyuanp/nerdtree-git-plugin' " visual git status for nerdtre visual git status for nerdtree
    Plug 'airblade/vim-gitgutter' " Viewing git changes
    Plug 'airblade/vim-rooter' " Viewing git changes
    Plug 'ctrlpvim/ctrlp.vim' " Fuzzy search, MRU, and Buffer viewer
    Plug 'itchyny/lightline.vim' " equivalent to powerline
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder for vim
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim' " no-distraction mode
    Plug 'junegunn/limelight.vim' " Fucus on block
    Plug 'maxbrunsfeld/vim-yankstack' " multiple yanks
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree' " fm integration
    Plug 'tpope/vim-fugitive' " git support
    Plug 'vim-scripts/TaskList.vim'
"syntax
    Plug 'tpope/vim-markdown' " markdown support
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown preview
    " TODO 04/08/20 10:41 > need to fix markdown-preview not working
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion and more
    Plug 'tpope/vim-surround' " surround with quotes

"color-schemes
    Plug 'doums/darcula'
    Plug 'morhetz/gruvbox'
    Plug 'chriskempson/base16-vim'
    Plug 'junegunn/seoul256.vim'
call plug#end()

"ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"Nerd Tree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1

let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], ['filetype'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \   'filename': 'FilenameForLightline',
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
  \ }
function! FilenameForLightline() " Show full path of filename
    return expand('%')
endfunction

"Goyo settings
function! s:goyo_enter()
    set noshowmode
    set nocursorline
    CocDisable
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set cursorline
    CocEnable
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" COC
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-vimlsp',
  \ 'coc-explorer',
  \ 'coc-json'
  \ ]
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"prettier
"autocmd! bufWrite * Prettier

"coc-vimlsp
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
"coc explore
let g:coc_explorer_global_presets = {
\
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" Use preset argument to open it
nmap <space>fe :CocCommand explorer --preset .vim<CR>
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
set lcs=tab:›\ ‹,trail:᎑,nbsp:+

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

set backspace=indent,eol,start " backspace behaviour
set tw=500 " number of characters per line (in which it breaks)

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

" commands and functions
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

filetype plugin indent on

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

" disable default bindings
nnoremap Q !!sh<CR>

" plugin bindings
nnoremap <leader><Space> :CtrlP<CR>
nnoremap <leader>g :Goyo<CR>
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
nmap <leader>/ <plug>NERDCommenterToggle
vmap <leader>/ <plug>NERDCommenterToggle

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
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" saving
nmap <leader>wq :wq<cr>
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
nmap <Leader>- mz:m+<cr>`z
nmap <Leader>= mz:m-2<cr>`z
vmap <Leader>- :m'>+<cr>`<my`>mzgv`yo`z
vmap <Leader>= :m'<-2<cr>`>my`<mzgv`yo`z

" Quickly open a buffer for scribble
map <leader>q :e ~/Documents/.buffer<cr>
" Quickly open a markdown buffer for scribble
map <leader>x :e ~/Documents/.md-buffer.md<cr>
" Quickly load config
map <leader>e :e! $XDG_CONFIG_HOME/nvim/init.vim<cr>
" Quick resourcing of the init
nnoremap <C-s> :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

" easier exit from insert mode
imap jk <esc>
"create shell buffer
nmap <leader>r :bo 15sp +te<cr>

map <leader>. :colo base16-
map <F1> :colorscheme darcula<CR>
map <F2> :colorscheme gruvbox<CR>
map <F3> :colorscheme base16-default-dark<CR>
map <F4> :colorscheme base16-ashes<CR>
map <F5> :colorscheme base16-onedark<CR>
map <F6> :colorscheme base16-tomorrow-night-eighties<CR>
map <F7> :colorscheme base16-paraiso<CR>
map <F8> :colorscheme base16-railscasts<CR>

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
"autocmd! BufEnter,BufNewFile *vim colo darcula
"autocmd! filetype *vim colo darcula

"autocmd! BufLeave *.html,*.vim,*xml colo gruvbox

"
"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE guifg=NONE  ctermfg=NONE
hi Search guibg=wheat guifg=purple


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"File Types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"python
au FileType python set colorcolumn=80
au FileType python iab todo # TODO <c-r>=strftime("%d/%m/%y %H:%M")<cr> >
let g:mkdp_browser = 'midori'

"vim
au FileType vim iab todo " TODO <c-r>=strftime("%d/%m/%y %H:%M")<cr> >

iab xjtodo // TODO <c-r>=strftime("%d/%m/%y")<cr> >

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Credits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this rc was built over a long period of time so I obviously borrowed parts of many other rc's
" I did not collect all of them but among them the ones that stand out more are
" Amir Salihefendic's:  https://github.com/amix/vimrc
" Nick Nisi's https://github.com/nicknisi/vim-workshop/blob/master/vimrc
" My own prefferations, and some minor picks from here and there...
