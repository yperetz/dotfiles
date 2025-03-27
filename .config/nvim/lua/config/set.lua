-- """"""""""""""""""""""""""""""""""""""""""
-- General Settings
-- """"""""""""""""""""""""""""""""""""""""""

vim.opt.incsearch = true  -- Incremental search view
vim.opt.magic = true      -- behaviour of slash in patterns
vim.opt.ignorecase = true -- case sensitivity
vim.opt.smartcase = true  -- no ignorecase when using upper case in search pattern

vim.opt.wrap = true       -- wrap long lines
vim.opt.showbreak = '⤥ '
vim.opt.so = 7            -- Set 7 lines to the cursor - when moving vertically using j/k
vim.opt.nu = true         -- Show line numbers
vim.opt.rnu = true        -- Show relative line numbers
vim.opt.lbr = true        --enable linebreak after 'tw' characters
vim.opt.textwidth = 500   -- number of characters per line (in which it breaks)
vim.opt.list = true       --enable shoing whitespaces"
vim.opt.listchars = { tab = "› ‹", trail = "᎑", nbsp = "+" }

-- vim.cmd("set shortmess+=c")    -- Don't pass messages to |ins-completion-menu|.")
vim.opt.background = "dark"
vim.opt.syntax = "on"
vim.opt.termguicolors = true -- use GUI colors for the terminal

vim.opt.cursorline = true    --highlight the line of the cursor
vim.opt.hlsearch = true      -- Highlight search results

vim.opt.laststatus = 2
vim.opt.hidden = true     -- Sets buffers are hidden instead of closed when moved from
vim.opt.autoread = true   -- Set to auto read when a file is changed from the outside
vim.opt.splitbelow = true -- split directions
vim.opt.splitright = true

vim.opt.mouse = "a"                    -- enable mouse in all modes
vim.opt.showcmd = true                 -- show partial commands on statusline
vim.opt.ruler = true                   --Always show current position
vim.opt.confirm = true                 -- start a dialog when a command fails

vim.opt.clipboard = "unnamedplus"      -- using the clipboard as default register
vim.opt.cmdheight = 2                  -- Give more space for displaying messages.

vim.opt.backspace = "indent,eol,start" -- backspace behaviour
vim.opt.updatetime = 300

-- <tab> behaviour
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

-- <tab> widths
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 4

vim.opt.writebackup = false -- don't backup before writing
vim.opt.backup = false      -- don't backup after writing
vim.opt.swapfile = false    -- dont write swap files
vim.opt.ffs = "unix,dos"    -- Use Unix as the standard file type


-- TODO 08/08/20 13:55 > define folding

vim.opt.history = 500   -- Sets how many lines of history VIM has to remember
vim.opt.wildmenu = true -- Turn on the Wild menu
-- set wildignore=*.o,*~,*.pyc " Ignore compiled files

vim.opt.encoding = "UTF-8" -- encoding you know
vim.cmd("filetype plugin indent on")
