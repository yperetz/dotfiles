--[[
 _   ________  ___  _____          ____                    __  _
| | / /  _/  |/  / / ___/__  ___  / _(_)__ ___ _________ _/ /_(_)__  ___
| |/ // // /|_/ / / /__/ _ \/ _ \/ _/ / _ `/ // / __/ _ `/ __/ / _ \/ _ \
|___/___/_/  /_/  \___/\___/_//_/_//_/\_, /\_,_/_/  \_,_/\__/_/\___/_//_/
                                     /___/

 ________________________  __ _____    ________________________
/___/___/___/___/___/___/ / // / _ \  /___/___/___/___/___/___/
           /___/___/___/  \_, / .__/ /___/___/___/
                         /___/_/
]]

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- """"""""""""""""""""""""""""""""""""""""""
-- Lazy Package Manager
-- """"""""""""""""""""""""""""""""""""""""""

require("config.lazy")
require("config.keymaps")
require("config.helpers")
require("config.set")

-- vim.cmd.colorscheme "gruvbox"
