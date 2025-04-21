local quickNotePath = vim.fn.expand("$QUICKNOTE_PATH")

vim.keymap.set("n", "<leader>no", function()
	vim.cmd("vsplit")
	vim.cmd("edit " .. vim.fn.fnameescape(quickNotePath))
	vim.cmd("vertical resize 80")
end, { desc = "Open Quick note" })
