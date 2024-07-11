return {
	"stevearc/conform.nvim",
	event = "VeryLazy",

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

				-- Conform will run multiple formatters sequentially
				-- python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
			},
			-- format_on_save = {
			-- 	-- These options will be passed to conform.format()
			-- timeout_ms = 500,
			-- lsp_fallback = true,
			-- },
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
