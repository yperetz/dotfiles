"key-bindings
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let mapleader=","

" Run command under cursor in shell
nnoremap Q !!sh<CR>

" navigating windows
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" saving
nmap <leader>ww :w<cr>
nmap <leader>ws :W<cr>

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

" easier exit from insert mode
imap jk <esc>

" sort alphabettically
vnoremap <leader>s :sort<cr>

" indentation w/o losing selectoin
vnoremap < <gv
vnoremap > >gv

" turn off highlight-searching
map <silent> <leader><cr> :noh<cr>

