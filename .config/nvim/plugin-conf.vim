"    ___  __          _
"   / _ \/ /_ _____ _(_)__
"  / ___/ / // / _ `/ / _ \
" /_/  /_/\_,_/\_, /_/_//_/
"             /___/
"   _____          ____                    __  _
"  / ___/__  ___  / _(_)__ ___ _________ _/ /_(_)__  ___
" / /__/ _ \/ _ \/ _/ / _ `/ // / __/ _ `/ __/ / _ \/ _ \
" \___/\___/_//_/_//_/\_, /\_,_/_/  \_,_/\__/_/\___/_//_/
"                    /___/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
"tools
    "Plug 'Xuyuanp/nerdtree-git-plugin' " visual git status for nerdtre visual git status for nerdtree
    "Plug 'ctrlpvim/ctrlp.vim' " Fuzzy search, MRU, and Buffer viewer
    "Plug 'scrooloose/nerdtree' " fm integration
    Plug 'airblade/vim-gitgutter' " Viewing git changes
    Plug 'airblade/vim-rooter' " Viewing git changes
    Plug 'itchyny/lightline.vim' " equivalent to powerline
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder for vim
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim' " no-distraction mode
    Plug 'junegunn/limelight.vim' " Fucus on block
    Plug 'maxbrunsfeld/vim-yankstack' " multiple yanks
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion and more
    Plug 'scrooloose/nerdcommenter' " comment in/out everywhere
    Plug 'tpope/vim-fugitive' " git support
    Plug 'vim-scripts/TaskList.vim' " Show TODOs
    Plug 'vimwiki/vimwiki' " organize notes
"syntax
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown preview
    Plug 'tpope/vim-markdown' " markdown support
    Plug 'tpope/vim-surround' " surround with quotes

"color-schemes
    Plug 'chriskempson/base16-vim'
    Plug 'doums/darcula'
    Plug 'jacoborus/tender.vim'
    Plug 'jnurmine/Zenburn'
    Plug 'junegunn/seoul256.vim'
    Plug 'morhetz/gruvbox'
    Plug 'tomasr/molokai'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:NERDTreeWinPos = "right"
"let NERDTreeShowHidden=1

"let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"let g:NERDTreeWinSize=35
"let g:NERDTreeDirArrows = 1
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-wiki
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/pentesting',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-python',
  \ 'coc-vimlsp',
  \ 'coc-explorer',
  \ 'coc-json'
  \ ]

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

" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline^=%{coc#status()}

"vimlsp
"------
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

let g:mkdp_auto_start = 0
"coc-explorer
"------------

let g:coc_explorer_global_presets = {
\
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   '.init': {
\     'root-uri': '~/.config/nvim',
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\     'explorer-datetime-format': 'dd/MM/yy HH:mm:ss',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" quit buffer if it's the last one
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'midori'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

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

