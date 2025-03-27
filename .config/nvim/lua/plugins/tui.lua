return {
    -- {
    --     "folke/which-key.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     },
    --     keys = {
    --         {
    --             "<leader>?",
    --             function()
    --                 require("which-key").show({ global = false })
    --             end,
    --             desc = "Buffer Local Keymaps (which-key)",
    --         },
    --     },
    --     dependencies = { { 'echasnovski/mini.nvim', version = '*' },
    --         { "nvim-tree/nvim-web-devicons", opts = {} } }
    --
    -- },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'base16',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    }

}
