return {
	{
		"stevearc/aerial.nvim",
		lazy = true,

		opts = {
			backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

			layout = {
				-- These control the width of the aerial window.
				-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_width and max_width can be a list of mixed types.
				-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
				max_width = { 45, 0.25 },
				width = nil,
				min_width = 30,

				-- key-value pairs of window-local options for aerial window (e.g. winhl)
				win_opts = {},

				-- Determines the default direction to open the aerial window. The 'prefer'
				-- options will open the window in the other direction *if* there is a
				-- different buffer in the way of the preferred direction
				-- Enum: prefer_right, prefer_left, right, left, float
				default_direction = "right",

				-- Determines where the aerial window will be opened
				--   edge   - open aerial at the far right/left of the editor
				--   window - open aerial to the right/left of the current window
				placement = "window",

				-- When the symbols change, resize the aerial window (within min/max constraints) to fit
				resize_to_content = true,

				-- Preserve window size equality with (:help CTRL-W_=)
				preserve_equality = false,
			},
			-- A list of all symbols to display. Set to false to display all symbols.
			-- This can be a filetype map (see :help aerial-filetype-map)
			-- To see all available values, see :help SymbolKind
			filter_kind = false,
		},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { desc = "Aerial: Prev" }),
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { desc = "Aerial: Next" }),
		vim.keymap.set("n", "<leader><leader>", "<cmd>AerialToggle!<CR>", { desc = "Aerial: Toggle" }),
	},
}
