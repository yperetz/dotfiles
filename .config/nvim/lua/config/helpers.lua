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

vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- or ">>", "❗", "🔥", etc. (or "" for none)
    spacing = 4,  -- space between code and the message
  },
  signs = true,        -- show signs in the gutter
  underline = true,    -- underline problematic text
  update_in_insert = false, -- don't show during insert mode
  severity_sort = true,     -- sort by severity
})
