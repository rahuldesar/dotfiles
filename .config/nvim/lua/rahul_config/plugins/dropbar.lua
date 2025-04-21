return {
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<leader>'", dropbar_api.pick, { desc = "Dropbar: Pick symbols in winbar" })
			vim.keymap.set(
				"n",
				"[;",
				dropbar_api.goto_context_start,
				{ desc = "Dropbar: Go to start of current context" }
			)
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: Select next context" })
			vim.keymap.set(
				"n",
				"z;",
				dropbar_api.goto_context_start,
				{ desc = "Dropbar: Go to start of current context" }
			)
			vim.keymap.set("n", "zq", dropbar_api.select_next_context, { desc = "Dropbar: Select next context" })
		end,
	},
}
