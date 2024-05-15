return {
	"stevearc/conform.nvim",

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettier", "prettierd" } },
				javascriptreact = { { "prettier", "prettierd" } },
				typescript = { { "prettier", "prettierd" } },
				typescriptreact = { { "prettier", "prettierd" } },
				markdown = { { "prettier", "prettierd" } },
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
				timeout_ms = 500,
				lsp_fallback = true,
			})
		end

		vim.keymap.set("n", "<leader>;", format_buffer, { desc = "[F]ormat" })
	end,
}
