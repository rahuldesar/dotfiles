local kind_icons = {
	-- Basic Types
	Text = "󰊄 ",
	Variable = "󰫧 ", -- Default: "󰆦"
	Constant = "󰏿 ",
	Value = "󰦨 ",

	-- Functions & Methods
	Function = "󰊕 ",
	Method = "󰡱 ",
	Constructor = "󰒓 ",

	-- Object-Oriented Programming
	Class = " ", -- Default: "󱡠"
	Interface = " ", -- Default: "󱡠"
	Struct = "󱡠 ",
	TypeParameter = "󰬛 ",

	-- Fields & Properties
	Field = "󰜢 ",
	Property = "󰖷 ",
	Enum = " ",
	EnumMember = "󰦨 ",

	-- Keywords & Operators
	Keyword = "󰌋 ", -- Default: "󰻾"
	Operator = "󰆕 ", -- Default: "󰪚"

	-- Modules & References
	Module = " ", -- Default: "󰅩"
	Reference = " ", -- Default: "󰬲"

	-- Snippets & Code Utilities
	Snippet = " ",
	Unit = " ", -- Default: "󰪚"

	-- Files & Folders
	File = "󰈔 ",
	Folder = "󰉋 ",

	-- Miscellaneous
	Color = "󰏘 ",
	Event = "󱐋 ",
}

return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "BufWinEnter",
		init = function() vim.g.copilot_no_maps = true end,
		config = function()
			-- Block the normal Copilot suggestions
			vim.api.nvim_create_augroup("github_copilot", { clear = true })
			vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
				group = "github_copilot",
				callback = function(args) vim.fn["copilot#On" .. args.event]() end,
			})
			vim.fn["copilot#OnFileType"]()
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "Kaiser-Yang/blink-cmp-git" },
			{ "fang2hou/blink-copilot" },
			{ "rafamadriz/friendly-snippets" },
			{ "bydlw98/blink-cmp-env" },
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
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
				["<Tab>"] = {},
				["<S-Tab>"] = {},
				["<C-b>"] = {},
				["<C-f>"] = {},
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 300 },
				ghost_text = { enabled = true },
				menu = {
					draw = {
						treesitter = { "lsp" },
						-- similar to nvim-cmp styling
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
					},
				},
				list = { selection = { auto_insert = false } },
			},
			--  INFO: Luasnip loads snippets from ~/.config/nvim-snippets/ (setting in `lsp.lua`)
			cmdline = { enabled = true, completion = { menu = { auto_show = true } } },
			snippets = { preset = "luasnip" },
			sources = {
				-- , "dictionary"
				-- default = { "copilot" },
				-- "env",
				default = { "lsp", "buffer", "lazydev", "snippets", "path" },
				per_filetype = {
					sql = { "snippets", "copilot", "dadbod", "buffer", "lsp" },
					gitcommit = { "snippets", "git", "buffer", "lsp" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},

					git = {
						module = "blink-cmp-git",
						name = "Git",
						opts = {
							-- options for the blink-cmp-git
						},
					},

					env = {
						name = "Env",
						module = "blink-cmp-env",
						opts = {
							-- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
							-- show_braces = false,
							show_documentation_window = true,
						},
					},

					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},

					-- Database
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },

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
