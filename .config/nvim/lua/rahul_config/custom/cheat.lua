local telescope = require("rahul_config.plugins.telescope")
local cheatDir = vim.fn.expand("$HOME/.config/cheatsheet")
local codeExampleDir = vim.fn.expand("$HOME/Developer/Personal/reference/code-examples")

local cheatsheetToFiletypeMap = {
	postgres = { "sql", "mysql" },
	bash = { "sh" },
	conventional_commits = { "git-commit" },
	react = { "javascriptreact", "typescriptreact" },
}

local function getCheatsheetFromFiletype(map, filetype)
	for key, values in pairs(map) do
		for _, value in ipairs(values) do
			if value == filetype then
				return key
			end
		end
	end
	return filetype
end

vim.fn.mkdir(cheatDir, "p")
local function openCheatsheet()
	local currFiletype = vim.bo.filetype
	local cheatsheetFile = getCheatsheetFromFiletype(cheatsheetToFiletypeMap, currFiletype)
	local cheatFile = string.format("%s/%s.md", cheatDir, cheatsheetFile)

	if vim.fn.filereadable(cheatFile) == 0 then
		-- vim.notify("Cheatsheet not found: " .. cheatFile, vim.log.levels.INFO)
		local url = "https://cheat.sh/" .. currFiletype

		vim.fn.writefile({ "# Cheatsheet for " .. currFiletype }, cheatFile)
		vim.fn.writefile({ "" }, cheatFile, "a")
		vim.fn.writefile({ "For starter use: `curl " .. url .. "`" }, cheatFile, "a")

		vim.notify("Created new cheatsheet: " .. cheatFile, vim.log.levels.INFO)
	end

	vim.cmd("tabnew")
	vim.cmd("edit " .. vim.fn.fnameescape(cheatFile))
	vim.cmd("AerialToggle!")
end

local function openExampleList()
	local currFiletype = vim.bo.filetype
	local fullPath = string.format("%s/%s", codeExampleDir, currFiletype)

	if vim.fn.isdirectory(fullPath) == 0 then
		vim.notify("No Code Example found: `code-examples/" .. currFiletype .. "`", vim.log.levels.ERROR)
		return
	end

	vim.cmd("tabnew")
	require("telescope.builtin").find_files({
		cwd = fullPath,
	})
end

vim.keymap.set("n", "<leader>ch", function() openCheatsheet() end, { desc = "Open [c]heatsheet" })
vim.keymap.set("n", "<leader>cc", function() openCheatsheet() end, { desc = "Open [c]heatsheet" })
vim.keymap.set("n", "<leader>cx", function()
	vim.cmd("tabnew")
	require("telescope.builtin").find_files({
		cwd = cheatDir,
	})
end, { desc = "Telescope [c]heatsheet directory" })

vim.keymap.set("n", "<leader>ce", function() openExampleList() end, { desc = "Open [c]ode [e]xample" })
