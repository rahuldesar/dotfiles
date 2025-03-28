local opts = { noremap = true, silent = true }

function neogen_init(type) return ":lua require('neogen').generate({type = \"" .. type .. '"})<CR>' end

return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			enabled = true,
			languages = {
				["bash"] = require("neogen.configurations.sh"),
			},
		})
	end,

	version = "*",

	vim.api.nvim_set_keymap("n", "dcf", neogen_init("func"), { desc = "Doc generate Function" }),
	vim.api.nvim_set_keymap("n", "dcc", neogen_init("class"), { desc = "Doc generate Class" }),
	vim.api.nvim_set_keymap("n", "dct", neogen_init("type"), { desc = "Doc generate Type" }),
}

-- INFO:  Alternative = "vim/doge"
