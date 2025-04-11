return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		notifier = {
			enabled = true,
			timeout = 3000,
			style = "compact",
		},
		picker = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
	},
	keys = {

		{
			"<leader>sb",
			function() Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } }) end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sB",
			function() Snacks.picker.lsp_workspace_symbols() end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>gg",
			function() Snacks.lazygit() end,
			desc = "Lazygit",
		},
		{
			"<leader>gb",
			function() Snacks.picker.git_branches() end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function() Snacks.picker.git_log() end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function() Snacks.picker.git_log_line() end,
			desc = "Git Log Line",
		},
		-- {
		-- 	"<leader>gs",
		-- 	function() Snacks.picker.git_status() end,
		-- 	desc = "Git Status",
		-- },
		{
			"<leader>gS",
			function() Snacks.picker.git_stash() end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function() Snacks.picker.git_diff() end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function() Snacks.picker.git_log_file() end,
			desc = "Git Log File",
		},

		{
			"<leader>,",
			function() Snacks.picker.buffers() end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function() Snacks.picker.grep() end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function() Snacks.picker.command_history() end,
			desc = "Command History",
		},
		{
			"<leader>nn",
			function() Snacks.picker.notifications() end,
			desc = "Notification History",
		},
		-- {
		-- 	"<leader><space>",
		-- 	function()
		-- 		Snacks.picker.smart()
		-- 	end,
		-- 	desc = "Smart Find Files",
		-- },

		{
			"<leader>ns",
			function() Snacks.notifier.hide() end,
			desc = "Dismiss All Notifications",
		},

		-- search
		-- { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{
			"<leader>s/",
			function() Snacks.picker.search_history() end,
			desc = "Search History",
		},
		{
			"<leader>sa",
			function() Snacks.picker.autocmds() end,
			desc = "Autocmds",
		},
		{
			"<leader>nb",
			function() Snacks.picker.lines() end,
			desc = "Buffer Lines",
		},

		{
			"<leader>nc",
			function() Snacks.picker.command_history() end,
			desc = "Command History",
		},
		{
			"<leader>nC",
			function() Snacks.picker.commands() end,
			desc = "Commands",
		},
		{
			"<leader>nd",
			function() Snacks.picker.diagnostics() end,
			desc = "Diagnostics",
		},
		{
			"<leader>nD",
			function() Snacks.picker.diagnostics_buffer() end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			function() Snacks.picker.help() end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function() Snacks.picker.highlights() end,
			desc = "Highlights",
		},
		{
			"<leader>nj",
			function() Snacks.picker.jumps() end,
			desc = "Jumps",
		},
		{
			"<leader>nm",
			function() Snacks.picker.marks() end,
			desc = "Marks",
		},
		{
			"<leader>nM",
			function() Snacks.picker.man() end,
			desc = "Man Pages",
		},
		{
			"<leader>np",
			function() Snacks.picker.lazy() end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>nq",
			function() Snacks.picker.qflist() end,
			desc = "Quickfix List",
		},
		{
			"<leader>nR",
			function() Snacks.picker.resume() end,
			desc = "Resume",
		},
		{
			"<leader>nu",
			function() Snacks.picker.undo() end,
			desc = "Undo History",
		},
		{
			"<leader>sc",
			function() Snacks.picker.colorschemes() end,
			desc = "Colorschemes",
		},
		{
			"<leader>gB",
			function() Snacks.gitbrowse() end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
	},
}
