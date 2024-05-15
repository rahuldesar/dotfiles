return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
	},

	config = function()
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set
		local themes = require("telescope.themes")
		map("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
		map("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		map("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
		map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		map("n", "<leader>sc", builtin.colorscheme, { desc = "[S]witch [C]olorscheme" })
		map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		-- Might have to change this binding
		map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>st", builtin.treesitter, { desc = "[S]earch [T]reesitter" })
		map("n", "<leader>sS", builtin.lsp_document_symbols, { desc = "Symbols" })

		map("n", "<leader>sm", builtin.keymaps, { desc = "[S]earch key[m]aps" })
		map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		map("n", "<leader>sv", builtin.vim_options, { desc = "[S]earch [V]im Options" })

		map("n", "<leader>sG", builtin.git_files, { desc = "[S]earch [G]it Files" })
		map("n", "<leader>Gc", builtin.git_commits, { desc = "Search [G]it [C]ommits" })
		map("n", "<leader>Gb", builtin.git_branches, { desc = "Search [G]it [B]ranches" })
		map("n", "<leader>Gs", builtin.git_status, { desc = "Search [G]it [S]tatus" })
		map("n", "<leader>Gg", builtin.git_stash, { desc = "Search [G]it Stash" })

		map("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "Search Word Under cursor Case insensitive" })

		map("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Search Word Under cursor Case seWsitive" })

		map("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		map("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "[S]earch [N]eovim files" })

		require("telescope").setup({
			defaults = {
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
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
