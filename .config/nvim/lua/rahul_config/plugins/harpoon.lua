return {
	"theprimeagen/harpoon",
	event = "VimEnter",

	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local set = vim.keymap.set

		set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add to List" })
		set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Toggle Quick Menu" })

		for i = 1, 5 do
			set(
				"n",
				string.format("<leader>%s", i),
				function() ui.nav_file(i) end,
				{ desc = "Harpoon: Go to File: " .. i }
			)
		end
	end,
}
