-- For `plugins/markview.lua` users.
return {
	"OXY2DEV/markview.nvim",
	lazy = true,
	config = function()
		local presets = require("markview.presets")
		require("markview").setup({
			preview = {
				icon_provider = "internal", -- "mini" or "devicons"
			},

			markdown = {
				headings = presets.headings.glow,
				horizontal_rules = presets.horizontal_rules.thin,
				tables = presets.tables.single,
				checkboxes = presets.checkboxes.nerd,
			},
		})
	end,
}
