-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Comment nvim
local api = vim.api
api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = false, silent = true }) -- normal
api.nvim_set_keymap('v', '<C-_>', 'gc', { noremap = false, silent = true })  -- visual

-- Undotree:
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- netrw
vim.keymap.set('n', '<leader>v', vim.cmd.Lexplore)


local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Todo-comments
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Run command under cursor in shell
keymap("n", "Q", "!!sh<CR>", opts)

-- Quick notes
keymap("n", "<leader>ee", ":e ~/Documents/notes/quick.md<CR>", opts)
keymap("n", "<leader>el", ":e ~/Documents/notes/to-learn.md<CR>", opts)

-- Splitting
keymap("n", "<leader>ss", ":vs ", opts)
keymap("n", "<leader>sh", ":split ", opts)

-- Navigating windows
keymap("n", "<leader>h", "<C-W>h", opts)
keymap("n", "<leader>j", "<C-W>j", opts)
keymap("n", "<leader>k", "<C-W>k", opts)
keymap("n", "<leader>l", "<C-W>l", opts)
keymap("n", "<leader>p", "<C-W>p", opts)

-- Saving
-- Save with formatting
vim.keymap.set("n", "<leader>ww", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd("w") -- Save the file after formatting
end, { desc = "Format and save file" })

-- Save without formatting
vim.keymap.set("n", "<leader>wq", ":w<CR>", { desc = "Save file without formatting" })

-- Buffer navigation
keymap("n", "<leader>bl", ":bnext<CR>", opts)
keymap("n", "<leader>bh", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdel<CR>", opts)

-- Move a line of text using [-+]
keymap("n", "+", "mz:m+<CR>`z", opts)
keymap("n", "-", "mz:m-2<CR>`z", opts)
keymap("v", "+", ":m'>+<CR>`<my`>mzgv`yo`z", opts)
keymap("v", "-", ":m'<-2<CR>`>my`<mzgv`yo`z", opts)

-- Easier exit from insert mode
keymap("i", "jk", "<ESC>", opts)

-- Sort alphabetically
keymap("v", "<leader>s", ":sort<CR>", opts)

-- Indentation without losing selection
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Turn off highlight searching
keymap("n", "<leader><CR>", ":noh<CR>", opts)

-- vim.keymap.set("n", "gr", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- terminal open
keymap("n", "<leader>t", ":botright 15split +terminal<CR>", opts)

-- resize window
keymap("n", "<Up>", ":resize +2<CR>", opts)
keymap("n", "<Down>", ":resize -2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)
