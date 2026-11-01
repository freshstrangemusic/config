if vim.g.neovide then
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0

    -- Use 14pt Fira Code as the font.
    vim.opt.guifont = "Fira Code:h14"
end

-- This needs to be set before including any plugins that define keymappings that reference the
-- leader.
vim.g.mapleader = "," -- `,` is more ergonomic than `\`.
vim.g.maplocalleader = ","

vim.opt.backup = false -- Do not generate backups automatically.
vim.opt.cursorline = true -- Highlight the currently edited line.
vim.opt.fileformat = "unix" -- Always use CRLF line endings.
vim.opt.joinspaces = false -- Do not insert two spaces after punctuation when joining lines.
vim.opt.list = true -- Enable list mode to display whitespace characters and scroll positions.
-- Display space as a middle dot.
 -- Use </> for the last characters before scrolling.
vim.opt.listchars:append("space:·,extends:>,precedes:<")
vim.opt.number = true -- Enable line numbers.
vim.opt.relativenumber = true -- Use relative line numbers.
vim.opt.ruler = true -- Show position in line and file.
vim.opt.scrolloff = 10 -- Show at least 10 lines of vertical context.
vim.opt.sidescrolloff = 10 -- Show at least 10 characters of horizontal context.
vim.opt.termguicolors = true -- Enable 256 colours in terminal.
vim.opt.textwidth = 100 -- Prefer longer lines.
vim.opt.undofile = true -- Enable undo across sessions.
vim.opt.wildmenu = true -- Enable tab-based autocompletion for commands.
vim.opt.wrap = false -- Do not wrap text.

require("config.bootstrap")
require("lazy").setup("plugins")

vim.keymap.set(
    "n",
    "<Leader>ff",
    ":Telescope find_files find_command=rg,--files,--hidden,--ignore,--iglob=!.git/ <CR>"
)

