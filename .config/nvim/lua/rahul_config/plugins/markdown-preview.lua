return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,

	config = function()
		vim.keymap.set(
			"n",
			"<leader>mp",
			":MarkdownPreviewToggle<CR>",
			{ noremap = true, silent = false, desc = "Toggle Markdown Preview" }
		)
	end,
}
