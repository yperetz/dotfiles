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
source $XDG_CONFIG_HOME/nvim/general.vim
source $XDG_CONFIG_HOME/nvim/keymaps.vim
source $XDG_CONFIG_HOME/nvim/plugin-conf.vim
source $XDG_CONFIG_HOME/nvim/filetype-conf.vim


"Functions
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"source init after each save
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim


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


" plugin bindings
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

" window bindings
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" splits
nnoremap <leader>sh :sf
nnoremap <leader>ss :vert sf

" resize window
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>


" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Close the current buffer
map <leader>bq :bd<cr>
" Close all the buffers
map <leader>ba :bufdo bd<cr>
map <leader>bl :bnext<cr>
map <leader>bh :bprevious<cr>
map <leader>bo :BufOnly<cr>
"show buffers
nmap <leader>bb :Buffers<cr>

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

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gui
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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
hi Search gui=NONE guibg=wheat guifg=purple

hi Todo gui=NONE guibg=Yellow guifg=black
syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
hi def link myTodo Todo

