-- Use Vim settings, rather than Vi settings (required for some features)
vim.opt.compatible = false

-- Enable file type detection, plugins and indentation
--vim.cmd('filetype on')
--vim.cmd('filetype plugin on')
--vim.cmd('filetype indent on')

-- Cursor line highlighting
vim.opt.cursorline = true
-- vim.api.nvim_set_keymap("n", "<Leader>h", ":vert h<Space>", { noremap = true })

-- Show current mode on the last line
vim.opt.showmode = true

-- Set a dark color scheme
--vim.opt.background = 'dark'

-- Set the default color scheme
-- vim.cmd("highlight LineNr guifg=#a8a29e")
-- vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd("colorscheme catppuccin")

-- Configure status line
--vim.g.lightline = { colorscheme = 'onedark' }

-- Enable syntax highlighting
vim.opt.syntax = "on"

-- Set text width to 100 characters
vim.opt.textwidth = 120

-- Show line numbers (relative = relativenumber, absolute = number)
vim.opt.nu = true
vim.opt.relativenumber = true

-- Show command info
vim.opt.showcmd = true

-- Show matching parenthesis
vim.opt.showmatch = true

-- Highlight search terms
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Always set autoindent on
vim.opt.autoindent = true

-- Copy previous indent on autoindenting
vim.opt.copyindent = true
-- Enable smart indenting
vim.opt.smartindent = true
-- Set autoindent to use 2 spaces
vim.opt.shiftwidth = 2
-- Set tab width to 2 columns
vim.opt.tabstop = 2
-- ????
vim.opt.softtabstop = 2

vim.opt.expandtab = true

-- Set terminal's title
vim.opt.title = true

-- Enable mouse
vim.opt.mouse = "a"

-- Copy to system clipboard
--vim.opt.clipboard = "unnamedplus"

-- Automatically read files that have changed outside of Vim
vim.opt.autoread = true

-- Enable undo history
vim.opt.undofile = true

-- Show file info in the status line
vim.opt.laststatus = 2

-- Enable visual mode mouse dragging
vim.opt.mouse = vim.opt.mouse + "a"

-- Enable vertical split by default
vim.o.splitright = true
-- vim.opt.splitright = true
-- vim.opt.splitbelow = false

-- Backup stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.scrolloff = 5

-- Set fold method and expression
-- vim.cmd("set foldmethod=expr")
-- vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
-- vim.cmd("set nofoldenable") -- Disable folding at startup

vim.cmd("set foldmethod=indent")
vim.cmd("set foldnestmax=10")
vim.cmd("set nofoldenable") -- Disable folding at startup
-- vim.cmd('set foldlevel=2')
-- set foldmethod=indent
-- set foldnestmax=10
-- set nofoldenable
-- set foldlevel=2
