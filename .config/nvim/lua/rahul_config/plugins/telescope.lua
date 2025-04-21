return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"jmacadie/telescope-hierarchy.nvim",
			keys = {
				{ -- lazy style key map
					-- Choose your own keys, this works for me
					"<leader>si",
					"<cmd>Telescope hierarchy incoming_calls<cr>",
					desc = "LSP: [S]earch [I]ncoming Calls",
				},
				{
					"<leader>so",
					"<cmd>Telescope hierarchy outgoingcalls<cr>",
					desc = "LSP: [S]earch [O]utgoing Calls",
				},
			},
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function() return vim.fn.executable("make") == 1 end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "benfowler/telescope-luasnip.nvim" },
		{ "piersolenski/telescope-import.nvim" },
		{ "nvim-telescope/telescope-smart-history.nvim" },
		{ "kkharji/sqlite.lua" },
		{
			"nvim-telescope/telescope-frecency.nvim",
			-- install the latest stable version
			version = "*",
			config = function() require("telescope").load_extension("frecency") end,
		},
		{ "nvim-telescope/telescope-cheat.nvim" },
	},

	config = function()
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set
		local themes = require("telescope.themes")
		local lst = require("telescope").extensions.luasnip
		local luasnip = require("luasnip")
		map("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
		map(
			"n",
			"<leader>/",
			function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			{ desc = "[/] Fuzzily search in current buffer" }
		)

		map(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
			{ desc = "[S]earch [F]iles" }
		)

		map("n", "<leader>Ch", ":Telescope cheat fd<cr>", { desc = "Search [Ch]eat" })

		map("n", "<leader>im", "<cmd>Telescope import <cr>", { desc = "[S]earch [F]iles" })

		-- "<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
		map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		map("n", "<leader>sc", builtin.colorscheme, { desc = "[S]witch [C]olorscheme" })
		map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

		-- map("n", "<leader>sl", "<cmd>Telescope frecency<CR>", { desc = "[S]earch Recente" })
		map("n", "<leader>s-", "<cmd>Telescope luasnip<CR>", { desc = "[S]earch Snippets" })
		-- map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		-- Might have to change this binding
		-- map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>st", builtin.treesitter, { desc = "[S]earch [T]reesitter" })
		map("n", "<leader>sq", builtin.quickfix, { desc = "[S]earch [Q]uickfix" })
		map("n", "<leader>sS", builtin.lsp_document_symbols, { desc = "[S]earch Document [S]ymbols" })

		-- Enhanced Symbol Navigation
		map("n", "<leader>sw", builtin.lsp_workspace_symbols, { desc = "[S]earch [W]orkspace Symbols" })
		map("n", "<leader>lsi", builtin.lsp_incoming_calls, { desc = "[S]earch [I]ncoming Calls" })
		map("n", "<leader>lso", builtin.lsp_outgoing_calls, { desc = "[S]earch [O]utgoing Calls" })
		map("n", "<leader>lsr", builtin.lsp_references, { desc = "[S]earch [R]eferences" })
		map("n", "<leader>lsd", builtin.lsp_definitions, { desc = "[S]earch [D]efinitions" })
		map("n", "<leader>lst", builtin.lsp_type_definitions, { desc = "[S]earch [T]ype Definitions" })
		map("n", "<leader>lsi", builtin.lsp_implementations, { desc = "[S]earch [I]mplementations" })

		map("n", "<leader>sm", builtin.keymaps, { desc = "[S]earch key[m]aps" })
		map("n", "<leader>ft", builtin.filetypes, { desc = "Set [F]ile[T]ype" })
		-- builtin.filetypes
		-- map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		map("n", "<leader>sv", builtin.vim_options, { desc = "[S]earch [V]im Options" })

		map("n", "<leader>sG", builtin.git_files, { desc = "[S]earch [G]it Files" })
		map("n", "<leader>Gc", builtin.git_commits, { desc = "Search [G]it [C]ommits" })
		map("n", "<leader>Gb", builtin.git_branches, { desc = "Search [G]it [B]ranches" })
		-- map("n", "<leader>Gs", builtin.git_status, { desc = "Search [G]it [S]tatus" })
		map("n", "<leader>Gg", builtin.git_stash, { desc = "Search [G]it Stash" })

		map("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "Search Word Under cursor Case insensitive" })

		map("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Search Word Under cursor Case seWsitive" })

		map("n", "<leader>ps", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)

		map(
			"n",
			"<leader>sn",
			function()
				builtin.live_grep({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			{ desc = "[S]earch words in [N]eovim config" }
		)

		require("telescope").setup({
			defaults = {
				prompt_prefix = "❯ ",

				file_ignore_patterns = {
					"node_modules/.*",
					-- "%.env",
					"yarn.lock",
					"pnpm%-lock.yaml",
					"package%-lock.json",
					"lazy%-lock.json",
					".git/.*",
					".svelte%-kit",
					"Session.vim",
				},
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
						results_width = 0.7,
					},
					vertical = {
						mirror = false,
					},
					width = 0.90,
					height = 0.85,
					preview_cutoff = 120,
				},
				mappings = {
					i = {
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key",
					},
				},
			},
			pickers = {
				current_buffer_fuzzy_find = {
					theme = "ivy",
				},
				find_files = {
					hidden = true,
				},
			},

			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				luasnip = require("telescope.themes").get_dropdown({
					border = true,
					preview = {
						check_mime_type = true,
					},
					layout_config = {
						width = 120,
						prompt_position = "bottom",
					},
				}),
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "luasnip")

		pcall(require("telescope").load_extension("hierarchy"))
		pcall(require("telescope").load_extension("import"))
		pcall(require("telescope").load_extension("cheat"))
	end,
}
