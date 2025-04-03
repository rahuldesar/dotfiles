return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		-- {
		-- 	"<leader>tt",
		-- 	"<cmd>Trouble diagnostics toggle<cr>",
		-- 	desc = "Diagnostics (Trouble)",
		-- },
		--
		-- {
		-- 	"[t",
		-- 	"<cmd>Trouble diagnostics prev<cr>",
		-- 	desc = "Diagnostics (Trouble)",
		-- },
		--
		-- {
		-- 	"]t",
		-- 	"<cmd>Trouble diagnostics next<cr>",
		-- 	desc = "Diagnostics (Trouble)",
		-- },
	},

	config = function() require("trouble").setup({}) end,
	vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" }),
	vim.keymap.set("n", "[t", "<cmd>Trouble diagnostics prev<cr>", { desc = "Diagnostics (Trouble)" }),
	vim.keymap.set("n", "]t", "<cmd>Trouble diagnostics next<cr>", { desc = "Diagnostics (Trouble)" }),
}
