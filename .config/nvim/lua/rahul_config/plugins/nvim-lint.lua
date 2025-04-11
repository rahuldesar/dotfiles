return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",

	config = function()
		local lint = require("lint")
		if lint.linters.markdownlint then
			lint.linters.markdownlint.args = { "--disable", "MD013", "--" }
		end

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },
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
		local luacheck = require("lint").linters.luacheck
		luacheck.args = {
			"--globals",
			"vim",
			"love",
			"reload",
		}
		-- TODO: , "InsertLeave", "TextChanged"
		--
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function() require("lint").try_lint() end,
		})
	end,
}
