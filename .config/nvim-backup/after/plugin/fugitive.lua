-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]how" });

vim.keymap.set("n", "<leader>gs", function()
  vim.cmd("vertical leftabove Git")
end, { desc = "[G]it [S]how" })

