-- For `plugins/markview.lua` users.
return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	config = function()
		local presets = require("markview.presets")
		require("markview").setup({
			preview = {
				icon_provider = "internal", -- "mini" or "devicons"
			},

			markdown = {
				headings = presets.headings.glow,
				horizontal_rules = presets.horizontal_rules.thin,
				tables = presets.tables.none,
				checkboxes = presets.checkboxes.nerd,
				list_items = {
					enable = true,
					wrap = false,

					indent_size = 1,
					shift_width = 1,

					marker_minus = {
						add_padding = false,
						conceal_on_checkboxes = true,

						-- text = "",
						text = "󰅂",
						hl = "MarkviewListItemMinus",
					},

					marker_plus = {
						add_padding = false,
						conceal_on_checkboxes = true,

						text = "",
						-- text = "",
						hl = "MarkviewListItemPlus",
					},

					marker_star = {
						add_padding = false,
						conceal_on_checkboxes = true,

						text = "",
						-- text = "",
						hl = "MarkviewListItemStar",
					},

					marker_dot = {
						add_padding = false,
						conceal_on_checkboxes = true,
					},

					marker_parenthesis = {
						add_padding = false,
						conceal_on_checkboxes = true,
					},
				},
			},
		})
	end,
}
