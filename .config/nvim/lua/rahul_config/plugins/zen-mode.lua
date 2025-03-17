return {
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.9,
					height = 1,
					-- width = 140,
					options = {
						number = true,
						relativenumber = true,

						signcolumn = "no",
						list = false,
						cursorline = false,
					},
				},
			})

			require("twilight").setup({
				dimming = {
					alpha = 0.7, -- amount of dimming
					-- we try to get the foreground from the highlight groups or fallback color
					color = { "Normal", "#ffffff" },
					term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
					inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
				},
				context = 10,
				treesitter = true,
			})

			vim.keymap.set("n", "<leader>Z", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle Zenmode" })
		end,
	},

	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				context = 0,
				treesitter = true,
			})
		end,
	},
}
