local opts = { noremap = true, silent = true }

function neogen_init(type)
	return ":lua require('neogen').generate({type = \"" .. type .. '"})<CR>'
end

return {
	"danymat/neogen",
	config = true,
	version = "*",

	vim.api.nvim_set_keymap("n", "dcf", neogen_init("func"), opts),
	vim.api.nvim_set_keymap("n", "dcc", neogen_init("class"), opts),
	vim.api.nvim_set_keymap("n", "dct", neogen_init("type"), opts),
}

-- INFO:  Alternative = "vim/doge"
