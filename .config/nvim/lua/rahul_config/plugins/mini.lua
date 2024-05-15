return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.surround").setup()

		-- NOTE: Better Around/Inside textobjects
		-- Examples:
		--  - `af` - around function call
		--  - `inq` - inside next quote
		require("mini.ai").setup({ n_lines = 500 })

		-- require("mini.bracketed").setup()
	end,
}
