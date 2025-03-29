local kind_icons = {
	-- Basic Types
	Text = "󰊄",
	Variable = "󰫧", -- Default: "󰆦"
	Constant = "󰏿",
	Value = "󰦨",

	-- Functions & Methods
	Function = "󰊕",
	Method = "󰡱",
	Constructor = "󰒓",

	-- Object-Oriented Programming
	Class = "", -- Default: "󱡠"
	Interface = "", -- Default: "󱡠"
	Struct = "󱡠",
	TypeParameter = "󰬛",

	-- Fields & Properties
	Field = "󰜢",
	Property = "󰖷",
	Enum = "",
	EnumMember = "󰦨",

	-- Keywords & Operators
	Keyword = "󰌋", -- Default: "󰻾"
	Operator = "󰆕", -- Default: "󰪚"

	-- Modules & References
	Module = "", -- Default: "󰅩"
	Reference = "", -- Default: "󰬲"

	-- Snippets & Code Utilities
	Snippet = "",
	Unit = "", -- Default: "󰪚"

	-- Files & Folders
	File = "󰈔",
	Folder = "󰉋",

	-- Miscellaneous
	Color = "󰏘",
	Event = "󱐋",
}

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
			{ "disrupted/blink-cmp-conventional-commits" },
			{ "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			appearance = {
				kind_icons = kind_icons,
			},
			keymap = {
				preset = "default",
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = {},
				["<S-Tab>"] = {},
				["<C-b>"] = {},
				["<C-f>"] = {},
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 300 },
				ghost_text = { enabled = true },
				menu = { draw = { treesitter = { "lsp" } } },
				list = { selection = { auto_insert = false } },
			},
			--  INFO: Luasnip loads snippets from ~/.config/nvim-snippets/ (setting in `lsp.lua`)
			snippets = { preset = "luasnip" },
			sources = {
				default = { "conventional_commits", "lazydev", "lsp", "path", "snippets", "buffer", "dictionary" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer", "lsp" },
				},

				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},

					-- Database
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },

					conventional_commits = {
						name = "Conventional Commits",
						module = "blink-cmp-conventional-commits",
						enabled = function() return vim.bo.filetype == "gitcommit" end,
						opts = {}, -- none so far
					},

					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						min_keyword_length = 3,
						opts = {
							dictionary_files = function() return { vim.fn.expand("~/.config/dictionary/words.txt") } end,
						},
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
