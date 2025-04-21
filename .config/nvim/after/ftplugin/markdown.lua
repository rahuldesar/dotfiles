vim.cmd("Markview enable")

vim.keymap.set(
	"n",
	"<leader>mp",
	"<cmd>MarkdownPreviewToggle<CR>",
	{ silent = true, desc = "Toggle Markdown Preview", buffer = true }
)
vim.keymap.set(
	"n",
	"<leader>pr",
	"<cmd>MarkdownPreviewToggle<CR>",
	{ silent = true, desc = "Toggle Markdown Preview", buffer = true }
)

vim.keymap.set("n", "<leader>mve", "<cmd>Markview<CR>", { silent = true, desc = "Enable MarkView", buffer = true })

vim.keymap.set(
	"n",
	"<leader>mvd",
	"<cmd>Markview Disable<CR>",
	{ silent = true, desc = "Disable MarkView", buffer = true }
)
