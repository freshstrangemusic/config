vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

if vim.g.neovide then
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0
end

-- This needs to be set before including any plugins that define keymappings that reference the
-- leader.
vim.g.mapleader = "," -- `,` is more ergonomic than `\`.
vim.g.maplocalleader = ","

vim.o.backup = false -- Do not generate backups automatically.
vim.o.cursorline = true -- Highlight the currently edited line.
vim.o.fileformat = "unix" -- Always use CRLF line endings.
vim.o.joinspaces = false -- Do not insert two spaces after punctuation when joining lines.
vim.o.number = true -- Enable line numbers.
vim.o.relativenumber = true -- Use relative line numbers.
vim.o.ruler = true -- Show position in line and file.
vim.o.scrolloff = 10 -- Show at least 10 lines above and below cursor.
vim.o.termguicolors = true -- Enable 256 colours in terminal.
vim.o.textwidth = 100 -- Prefer longer lines.
vim.o.undofile = true -- Enable undo across sessions.
vim.o.wildmenu = true -- Enable tab-based autocompletion for commands.
vim.o.wrap = false -- Do not wrap text.

