return {
	"Chaitanyabsprip/fastaction.nvim",
	---@type FastActionConfig
	opts = {},
	vim.keymap.set({ "n", "x" }, "<leader>k", '<cmd>lua require("fastaction").code_action()<CR>', { buffer = bufnr }),
}


