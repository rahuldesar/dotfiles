return {

	{
		"aaronik/treewalker.nvim",

		-- The following options are the defaults.
		-- Treewalker aims for sane defaults, so these are each individually optional,
		-- and setup() does not need to be called, so the whole opts block is optional as well.
		opts = {
			-- Whether to briefly highlight the node after jumping to it
			highlight = true,

			-- How long should above highlight last (in ms)
			highlight_duration = 250,

			-- The color of the above highlight. Must be a valid vim highlight group.
			-- (see :h highlight-group for options)
			highlight_group = "CursorLine",
		},
		-- movement
		vim.keymap.set("n", "K", "<Nop>", { noremap = true, silent = true }),
		vim.keymap.set("n", "K", "<cmd>Treewalker Up<cr>", { silent = false }),
		vim.keymap.set("n", "J", "<cmd>Treewalker Down<cr>", { silent = false }),
		vim.keymap.set("n", "H", "<cmd>Treewalker Left<cr>", { silent = false }),
		vim.keymap.set("n", "L", "<cmd>Treewalker Right<cr>", { silent = false }),

		vim.keymap.set("v", "<leader>k", "<cmd>Treewalker Up<cr>", { silent = false }),
		vim.keymap.set("v", "<leader>j", "<cmd>Treewalker Down<cr>", { silent = false }),
		vim.keymap.set("v", "<leader>h", "<cmd>Treewalker Left<cr>", { silent = false }),
		vim.keymap.set("v", "<leader>l", "<cmd>Treewalker Right<cr>", { silent = false }),

		-- swapping
		-- vim.keymap.set("n", "<C-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true }),
		-- vim.keymap.set("n", "<C-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true }),
		-- vim.keymap.set("n", "<C-S-h>", "<cmd>Treewalker SwapLeft<cr>", { silent = true }),
		-- vim.keymap.set("n", "<C-S-l>", "<cmd>Treewalker SwapRight<cr>", { silent = true }),
	},
}
