local quickNotePath = vim.fn.expand("$QUICKNOTE_PATH")

vim.keymap.set("n", "<leader>no", function()
	vim.cmd("vsplit")
	vim.cmd("edit " .. vim.fn.fnameescape(quickNotePath))
	vim.cmd("wincmd T")
	vim.cmd("AerialToggle!")
end, { desc = "Open Quick note" })
