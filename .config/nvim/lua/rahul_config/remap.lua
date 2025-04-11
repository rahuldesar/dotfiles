local map = vim.keymap.set

vim.g.mapleader = " "

-- FREE KEYTEST
-- map("n", "<leader>doc", '<cmd>:lua print("hello") <CR>', { desc = "yo" })

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
map("n", "-", "<C-^>")

--
-- map('n', "<C-j>", NvimTmuxNavigateDown)
-- map('n', "<C-k>", NvimTmuxNavigateUp)
-- map('n', "<C-l>", NvimTmuxNavigateRight)
-- map('n', "<C-\\>",NvimTmuxNavigateLastActive)
-- map('n', "<C-f>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- map("n", "<leader>z", "<C-w>o", { silent = true })
--
