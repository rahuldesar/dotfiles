local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<leader>b", vim.cmd.NvimTreeFindFileToggle, { desc = "Toggle File Explorer" })
map("n", "<C-b>", vim.cmd.NvimTreeFindFileToggle, { desc = "Toggle File Explorer" })
map("n", "<leader>\\", "Nop", { noremap = true, silent = true, desc = "Split Vertical" })
map("n", "<leader>\\", ":vsp<CR>", { noremap = true, silent = true, desc = "Split Vertical" })
-- map("n", "<leader>so", ":source $MYVIMRC<CR>", { silent = true, desc = "Reload nvim config" })
--
--map("n", "<leader>b", vim.cmd.Ex)

map("n", "<leader><Tab>", ":bnext<CR>", { desc = "Next Buffer", noremap = true, silent = true })
map("n", "<leader><S-Tab>", ":bprevious<CR>", { desc = "Previous Buffer", noremap = true, silent = true })
map("n", "]b", ":bnext<CR>", { desc = "Next Buffer", noremap = true, silent = true })
map("n", "[b", ":bprevious<CR>", { desc = "Previous Buffer", noremap = true, silent = true })

map("n", "<leader>x", ":bd!<CR>", { noremap = true, silent = true })

--vim.api.nvim_set_keymap('', '<C-w>', ':q<CR>', {noremap = true})

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Alt + UP" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Alt + DOWN" })

map("n", "<leader>j", "mzJ`z", { desc = "[J]oin without moving cursor, legacyKey=`J` " })

map("n", "<C-d>", "<C-d>zz", { desc = "[D]own half page, cursor at middle" })
map("n", "<C-u>", "<C-u>zz", { desc = "[U]p half page, cursor at middle" })

map("n", "n", "nzzzv", { desc = "Search next term in middle" })
map("n", "N", "Nzzzv", { desc = "Search previous term in middle" })

map("x", "<leader>p", [["_dP]], { desc = "[P]ut without overwriting buffer" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]eleting to void register" })

map({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to Clipboard" })
map({ "n", "v" }, "<C-S-c>", [["+y]], { desc = "Yank to Clipboard, Terminal style" })
map("n", "<leader>Y", [["+Y]], { desc = "[Y]ank whole line to Clipboard" })

map("n", "Q", "<nop>")
map("n", "<C-z>", "<nop>")
map("n", "<C-f>", "<cmd>!tmux neww tmux-sessionizer<CR>")

map("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- NOTE: Replaced by conform
-- map("n", "<leader>;", vim.lsp.buf.format, { desc = "[F]ormat" })

local function toggle_quickfix()
	local windows = vim.fn.getwininfo()
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			vim.cmd.cclose()
			return
		end
	end
	vim.cmd.copen()
end

map("n", "<leader>qt", toggle_quickfix, { desc = "Toggle Quickfix Window" })

map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Quickfix, Up" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Quickfix, Down" })
-- @INFO: temp - testing treewalker
-- map("n", "<leader>k", "<cmd>lnext<CR>zz")
-- map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--   { desc = ' S]ubstitute word on cursor' })
-- map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

map(
	"n",
	"<C-n>",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")

map("v", "<space>x", ":lua<CR>")

--
-- map('n', "<C-j>", NvimTmuxNavigateDown)
-- map('n', "<C-k>", NvimTmuxNavigateUp)
-- map('n', "<C-l>", NvimTmuxNavigateRight)
-- map('n', "<C-\\>",NvimTmuxNavigateLastActive)
-- map('n', "<C-f>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- map("n", "<leader>z", "<C-w>o", { silent = true })
--
--
--
-- INFO: filetype specific keybindings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function(ev)
		map("n", "<leader>pr", ":!cargo run<CR>", { desc = "Play Rust - cargo run" })
	end,
})

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape Escape exits terminal mode" })

map("n", "gV", "`[v`]", { desc = "Select Last Yank/Paste Area" })

--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- local group = vim.api.nvim_create_augroup("js_autostart", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript" },
	callback = function(ev)
		map("n", "<leader>pr", "<cmd>!node %<CR>", { silent = true }) -- NOTE: Used to using `pr` to run stuff (muscle memory from rust)
		map("n", "<leader>js", "<cmd>!node %<CR>", { silent = true })
	end,
	-- group = group,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript" },
	callback = function(ev)
		-- TODO: change from bun to something better
		map("n", "<leader>pr", "<cmd>!bun %<CR>", { silent = true })
		-- map("n", "<leader>js", "<cmd>!bun %<CR>", { silent = true })
	end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- INFO: Love this but it messes up with plugins like navbuddy
--
-- vim.cmd("highlight default DimInactiveWindows guifg=#666666")
--
-- -- When leaving a window, set all highlight groups to a "dimmed" hl_group
-- vim.api.nvim_create_autocmd({ "WinLeave" }, {
-- 	callback = function()
-- 		local highlights = {}
-- 		for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
-- 			table.insert(highlights, hl .. ":DimInactiveWindows")
-- 		end
-- 		vim.wo.winhighlight = table.concat(highlights, ",")
-- 	end,
-- })
--
-- -- When entering a window, restore all highlight groups to original
-- vim.api.nvim_create_autocmd({ "WinEnter" }, {
-- 	callback = function()
-- 		vim.wo.winhighlight = ""
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = vim.api.nvim_create_augroup("EqualizeSplits", {}),
	callback = function()
		local current_tab = vim.api.nvim_get_current_tabpage()
		vim.cmd("tabdo wincmd =")
		vim.api.nvim_set_current_tabpage(current_tab)
	end,
	desc = "Resize splits with terminal window",
})

-- vim.api.nvim_create_autocmd("CmdlineEnter", {
-- 	group = vim.api.nvim_create_augroup("gmr_cmdheight_1_on_cmdlineenter", { clear = true }),
-- 	desc = "Don't hide the status line when typing a command",
-- 	command = ":set cmdheight=2",
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	group = vim.api.nvim_create_augroup("gmr_cmdheight_0_on_cmdlineleave", { clear = true }),
-- 	desc = "Hide cmdline when not typing a command",
-- 	command = ":set cmdheight=1",
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "markdown" },
--   callback = function(ev)
--     -- TODO: change from bun to something better
--     map("n", "<leader>pr", "<cmd>MarkdownPreviewToggle<CR>", { silent = true })
--   end,
-- })
--
--
--
-- @INFO:  Might be harmful sometimes, but setting filetype 'bash' for every script is annoying
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.sh",
	command = "set filetype=bash",
})
