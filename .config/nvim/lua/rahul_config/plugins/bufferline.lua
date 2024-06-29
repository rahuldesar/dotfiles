---@diagnostic disable: missing-fields
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				themable = true,
				separator_style = "slant",
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = "nvim_lsp",

				offsets = {
					{
						filetype = "NvimTree",
						text = "|¯·..·|¯·..· ಠ╭╮ಠ ·..·¯|·..·¯|",
						text_align = "left",
						separator = true,
					},
				},

				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		})
	end,
}
