-- WARN: Buggy and unmaintained
return {
	{

		"sudormrfbin/cheatsheet.nvim",
		enabled = false,
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {},
		-- vim.keymap.set("n", "<leader>ch", ":Cheatsheet <cr>", { desc = "open [ch]eatsheet" }),
	},
	-- INFO: I dont really use this. Helpful to get the list and fuzzyfind through it though
	-- {
	-- 	"siawkz/nvim-cheatsh",
	-- 	dependencies = {
	-- 		"ibhagwan/fzf-lua",
	-- 	},
	-- 	opts = {
	-- 		position = "right",
	-- 	},
	--
	-- 	vim.keymap.set("n", "<leader>cl", ":CheatList <cr>", { desc = "open [ch]eatsheet" }),
	-- },
}
