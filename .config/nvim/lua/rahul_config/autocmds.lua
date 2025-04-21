-- ME: ============= MUST HAVES ============================
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- Restore cursor to file position in previous editing session
-- :INFO: dont remember adding this
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.w.auto_cursorline then
			vim.wo.cursorline = true
			vim.w.auto_cursorline = nil
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.wo.cursorline then
			vim.w.auto_cursorline = true
			vim.wo.cursorline = false
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = vim.api.nvim_create_augroup("EqualizeSplits", {}),
	callback = function()
		local current_tab = vim.api.nvim_get_current_tabpage()
		vim.cmd("tabdo wincmd =")
		vim.api.nvim_set_current_tabpage(current_tab)
	end,
	desc = "Resize splits with terminal window",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions.type == "move" then
			Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
		end
	end,
})

-- PERF: ============= ft Specifics  ============================
-- TODO: ftplugin might be better place for these
--- HACK: `<leader>pr` to run stuff (muscle memory from rust)

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "markdown" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>pr", "<cmd>MarkdownPreviewToggle<CR>", { silent = true, buffer = true })
-- 		vim.keymap.set("n", "<leader>mve", "<cmd>Markview<CR>", { silent = true, buffer = true })
-- 		vim.keymap.set("n", "<leader>mvd", "<cmd>Markview Disable<CR>", { silent = true, buffer = true })
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "csv" },
-- 	callback = function()
-- 		vim.cmd(":CsvViewEnable display_mode=border comment=# header_lnum=1<CR>")
-- 		vim.keymap.set(
-- 			"n",
-- 			"<leader>csv",
-- 			":CsvViewToggle display_mode=border comment=# header_lnum=1<CR>",
-- 			{ silent = true, buffer = true }
-- 		)
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "go" },
-- 	callback = function() vim.keymap.set("n", "<leader>doc", "<cmd>:GoDoc<CR>", { silent = true, buffer = true }) end,
-- })

-- -- INFO: filetype specific keybindings
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "rust" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>pr", ":!cargo run<CR>", { desc = "Play Rust - cargo run", buffer = true })
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "go" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>pr", ":!go run %<CR>", { desc = "Play Go - go run current file ", buffer = true })
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "lua" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>pr", "<cmd>!lua %<CR>", { desc = "Play lua - node run", buffer = true })
-- 	end,
-- 	-- group = group,
-- })

-- local group = vim.api.nvim_create_augroup("js_autostart", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "javascript" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>pr", "<cmd>!node %<CR>", { desc = "Play Javascript - node run", buffer = true })
-- 		vim.keymap.set("n", "<leader>js", "<cmd>!node %<CR>", { desc = "Play Javascript - node run", buffer = true })
-- 	end,
-- 	-- group = group,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "typescript" },
-- 	callback = function()
-- 		-- TODO: change from bun to something better
-- 		vim.keymay.set("n", "<leader>pr", "<cmd>!bun %<CR>", { desc = "Play Typescript - bun run", silent = true })
-- 		-- map("n", "<leader>js", "<cmd>!bun %<CR>", { silent = true })
-- 	end,
-- })

-- WARN: ============= Testing  ============================
-- HACK:  Might be harmful sometimes, but setting filetype 'bash' for every script is annoying

-- HACK: I chatgpted this(with few modifications), but this works
vim.api.nvim_create_user_command("GetDictionary", function()
	local word = vim.fn.expand("<cword>")
	if word == "" then
		print("No word under cursor")
		return
	end

	local output = vim.fn.system({ "/Users/rahuldesar/scripts/dict", word })
	local contents = vim.split(output, "\n")
	local bufnr, winid = vim.lsp.util.open_floating_preview(contents, "txt", { border = "rounded" })

	-- Move cursor to the floating window
	if winid and vim.api.nvim_win_is_valid(winid) then
		vim.api.nvim_set_current_win(winid)
	end
end, {})
vim.keymap.set({ "n" }, "<leader>mm", ":GetDictionary<CR>", { desc = "Get Meaning" })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.sh",
	command = "set filetype=bash",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.env*",
	callback = function(args)
		vim.cmd("LspStop")
		-- vim.diagnostic.enable(false)
	end,
})

-- Diagnostic - Virtual Lines on current line only, while disabling virtual_text
vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
	callback = function()
		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
		if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
			vim.diagnostic.config({ virtual_text = true })
		else
			vim.diagnostic.config({ virtual_text = false })
		end
	end,
})
--
--
-- INFO:
--  ======= Love this but it messes up with plugins like navbuddy
--  When leaving a window, set all highlight groups to a "dimmed" hl_group
--
--[[ vim.cmd("highlight default DimInactiveWindows guifg=#666666")

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	callback = function()
		local highlights = {}
		for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
			table.insert(highlights, hl .. ":DimInactiveWindows")
		end
		vim.wo.winhighlight = table.concat(highlights, ",")
	end,
})

-- When entering a window, restore all highlight groups to original
vim.api.nvim_create_autocmd({ "WinEnter" }, {
	callback = function() vim.wo.winhighlight = "" end,
}) ]]

-- vim.api.nvim_create_autocmd("CmdlineEnter", {
-- 	group = vim.api.nvim_create_augroup("gmr_cmdheight_1_on_cmdlineenter", { clear = true }),
-- 	desc = "Don't hide the status line when typing a command",
-- 	command = ":set cmdheight=2",
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	group = vim.api.nvim_create_augroup("gmr_cmdheight_0_on_cmdlineleave", { clear = true }),
-- 	desc = "Hide cmdline when not typing a command",
-- 	command = ":set cmdheight=1",
-- })
