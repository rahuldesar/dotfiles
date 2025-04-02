return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",

	config = function()
		require("lint").linters_by_ft = {
			markdown = { "markdownlint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
			go = { "golangcilint" },
			javascript = { "eslint", "eslint_d" },
			python = { "pylint" },
			-- javascriptreact = { "eslint", "eslint_d" },
			-- typescript = { "eslint", "eslint_d" },
			-- typescriptreact = { "eslint", "eslint_d" },
			-- astro = { "eslint", "eslint_d" },
			-- svelte = { "eslint", "eslint_d" },
		}

		-- TODO: , "InsertLeave", "TextChanged"
		--
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function() require("lint").try_lint() end,
		})
	end,
}
