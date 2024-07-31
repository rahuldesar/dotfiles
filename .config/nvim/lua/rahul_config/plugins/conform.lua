return {
	"stevearc/conform.nvim",
	event = "VeryLazy",

	-- INFO: @RAHUL incase default config for formatter needs to be changed
	-- https://github.com/lukas-reineke/lsp-format.nvim#how-do-i-use-format-options

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettier", "prettierd" } },
				javascriptreact = { { "prettier", "prettierd" } },
				typescript = { { "prettier", "prettierd" } },
				typescriptreact = { { "prettier", "prettierd" } },
				markdown = { { "prettier", "prettierd" } },
				css = { { "prettier", "prettierd" } },
				json = { { "prettier", "prettierd" } },
				html = { { "prettier", "prettierd" } },
				yaml = { { "yamllint" } },
				sh = { { "shfmt" } },
				sql = { { "sqlfmt" } },
			},
		})

		local function format_buffer()
			require("conform").format({
				bufnr = vim.api.nvim_get_current_buf(),
				async = true,
				timeout_ms = 2000,
				lsp_fallback = true,
			})
		end

		vim.keymap.set("n", "<leader>;", format_buffer, { desc = "[F]ormat" })
	end,
}
