local actions = require("telescope.actions")

require("telescope").setup({
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer
                },
                n = {
                    ["d"] = actions.delete_buffer
                }
            }
        }
    }
})

vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = "HighlightYank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
})
