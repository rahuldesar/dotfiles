vim.keymap.set("n", "<leader>doc", "<cmd>:GoDoc<CR>", { silent = true, buffer = true , desc="GoDoc"})
vim.keymap.set("n", "<leader>pr", ":!go run %<CR>", { desc = "Play Go - go run current file ", buffer = true })
