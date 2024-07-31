return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",

	config = function()
		require("lint").linters_by_ft = {
			markdown = { "markdownlint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
			-- javascript = { "eslint", "eslint_d" },
			-- javascriptreact = { "eslint", "eslint_d" },
			-- typescript = { "eslint", "eslint_d" },
			-- typescriptreact = { "eslint", "eslint_d" },
			-- astro = { "eslint", "eslint_d" },
			-- svelte = { "eslint", "eslint_d" },
		}

		-- TODO: , "InsertLeave", "TextChanged"
		--
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()

				-- You can call `try_lint` with a linter name or a list of names to always
				-- run specific linters, independent of the `linters_by_ft` configuration
				-- require("lint").try_lint("cspell")
			end,
		})
	end,
}
