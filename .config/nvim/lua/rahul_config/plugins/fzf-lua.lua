return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {},

	vim.keymap.set(
		"n",
		"<C-g>",
		function() vim.cmd(":lua require('fzf-lua').builtin()") end,
		{ desc = "fzf builtins" }
	),

	vim.keymap.set(
		"n",
		"<leader>sa",
		function() vim.cmd(":lua require('fzf-lua').spell_suggest()") end,
		{ desc = "fzf builtins" }
	),
	vim.keymap.set(
		"n",
		"<leader>ca",
		function() vim.cmd(":lua require('fzf-lua').lsp_code_actions()") end,
		{ desc = "[C]ode [A]ction" }
	),

	vim.keymap.set(
		"n",
		"<C-m>",
		function() vim.cmd(":lua require('fzf-lua').lsp_workspace_symbols()") end,
		{ desc = "fzf workspace symbols" }
	),

	vim.keymap.set(
		"n",
		"gm",
		function() vim.cmd(":lua require('fzf-lua').lsp_document_symbols()") end,
		{ desc = "fzf document symbols" }
	),
}
