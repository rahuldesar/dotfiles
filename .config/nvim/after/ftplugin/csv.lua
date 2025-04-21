vim.cmd(":CsvViewEnable display_mode=border comment=# header_lnum=1<CR>")

vim.keymap.set(
	"n",
	"<leader>csv",
	":CsvViewToggle display_mode=border comment=# header_lnum=1<CR>",
	{ silent = true, buffer = true }
)
