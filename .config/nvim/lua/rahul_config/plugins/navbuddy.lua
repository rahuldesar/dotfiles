return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"SmiteshP/nvim-navic",
				"MunifTanjim/nui.nvim",
			},
			opts = {
				window = {
					border = "rounded", -- "rounded", "double", "solid", "none"
					-- or an array with eight chars building up the border in a clockwise fashion
					-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
					size = "80%", -- Or table format example: { height = "40%", width = "100%"}
					-- position = "50%", -- Or table format example: { row = "100%", col = "0%"}
					position = { row = "75%", col = "50%" }, -- Or table format example: { row = "100%", col = "0%"}
					scrolloff = nil, -- scrolloff value within navbuddy window
					sections = {
						left = {
							size = "20%",
							border = nil, -- You can set border style for each section individually as well.
						},
						mid = {
							size = "30%",
							border = nil,
						},
						right = {
							-- No size option for right most section. It fills to
							-- remaining area.
							border = nil,
							preview = "always", -- Right section can show previews too.
							-- Options: "leaf", "always" or "never"
						},
					},
				},

				lsp = { auto_attach = true },
			},
		},
	},

	config = function()
		vim.keymap.set("n", "<leader>sb", ":Navbuddy<CR>", { noremap = true, silent = true, desc = "Show Breadcrumps" })
	end,
	-- your lsp config or other stuff
}
