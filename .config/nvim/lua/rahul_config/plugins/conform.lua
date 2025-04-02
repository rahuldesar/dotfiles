return {
	"stevearc/conform.nvim",
	event = "VeryLazy",

	-- INFO: @RAHUL incase default config for formatter needs to be changed
	-- https://github.com/lukas-reineke/lsp-format.nvim#how-do-i-use-format-options

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", "prettierd", stop_after_first = true },
				javascriptreact = { "prettier", "prettierd", stop_after_first = true },
				typescript = { "prettier", "prettierd", stop_after_first = true },
				typescriptreact = { "prettier", "prettierd", stop_after_first = true },
				markdown = { "prettier", "prettierd", stop_after_first = true },
				css = { "prettier", "prettierd", stop_after_first = true },
				rust = { "rustfmt", lsp_format = "fallback" },
				go = { "gofumpt", "gofmt", lsp_format = "fallback" },
				json = { "prettier", "prettierd", stop_after_first = true },
				html = { "prettier", "prettierd", stop_after_first = true },
				yaml = { "yamllint" },
				sh = { "shfmt" },
				sql = { "sqlfmt" },
				python = { "black" },
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
