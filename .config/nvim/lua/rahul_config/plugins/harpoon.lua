return {
	"theprimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local set = vim.keymap.set

		set("n", "<leader>a", mark.add_file)
		set("n", "<C-e>", ui.toggle_quick_menu)

		for i = 1, 5 do
			set("n",
				string.format("<space>%s", i),
				function()
					require("harpoon.ui").nav_file(i)
				end
			)
		end
	end,
}
