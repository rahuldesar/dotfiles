-- WARN: Buggy and unmaintained
return {
	{

		"sudormrfbin/cheatsheet.nvim",
		-- lazy = true,
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {},
		-- vim.keymap.set("n", "<leader>ch", ":Cheatsheet <cr>", { desc = "open [ch]eatsheet" }),
	},
	{
		"siawkz/nvim-cheatsh",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		opts = {
			position = "right",
		},

		vim.keymap.set("n", "<leader>cl", ":CheatList <cr>", { desc = "open [ch]eatsheet" }),
	},
}
