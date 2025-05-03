return {
	{
		"olimorris/codecompanion.nvim",
		event = "BufEnter",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},

		vim.keymap.set("n", "<leader>co", ":CodeCompanionChat<cr>", { desc = "CodeCompanionChat" }),
		vim.keymap.set("v", "<leader>co", ":CodeCompanion<cr>", { desc = "CodeCompanion Inline" }),
		vim.keymap.set("n", "<leader>cp", ":CodeCompanionActions<cr>", { desc = "CodeCompanionActions Palette" }),
	},
}
