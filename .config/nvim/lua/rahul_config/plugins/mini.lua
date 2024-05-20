return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.surround").setup()
		--[[
  INFO: Todo-comments alternative
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
    ]]
		-- NOTE: Better Around/Inside textobjects
		-- Examples:
		--  - `af` - around function call
		--  - `inq` - inside next quote
		require("mini.ai").setup({ n_lines = 500 })

		-- require("mini.bracketed").setup()
	end,
}
