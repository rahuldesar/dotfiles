return {
	--  ========= LSP and  all the good stuff =============
	{
		"mbbill/undotree",
		config = function()
			-- undotree_WindowLayout
			vim.g.undotree_WindowLayout = 3
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
		end,
	},

	{ "tpope/vim-rhubarb" },

	--  TEST: testing mini
	-- { "tpope/vim-surround" },

	-- { "folke/neodev.nvim", opts = {} },

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- Lsp
			{ "neovim/nvim-lspconfig" },
			{ "marilari88/twoslash-queries.nvim" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				config = function()
					require("mason-tool-installer").setup({
						ensure_installed = {
							-- "tailwindcss-language-server",
							-- "js-debug-adapter",
							"typescript-language-server",
							"svelte-language-server",
							"codelldb",
							"eslint-lsp",
							"lua-language-server",
							"gopls",
							"rust-analyzer",
							"stylua",
							"vim-language-server",
							"editorconfig-checker",
							"golangci-lint",
							{ "bash-language-server", auto_update = true },
							"json-to-struct",
							"shellcheck",
							"shfmt",
							"vint",
						},
						start_delay = 2000,
					})
				end,
			},

			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
			},
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},

	-- {
	-- 	"evanleck/vim-svelte",
	-- 	branch = "main",
	--
	-- 	dependencies = {
	-- 		"othree/html5.vim",
	-- 		"pangloss/vim-javascript",
	-- 	},
	-- },

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"html",
			"astro",
		},
		config = function() require("nvim-ts-autotag").setup() end,
	},

	{ "numToStr/Comment.nvim", opts = {}, lazy = false },

	-- ======== Quality of Life ==========

	{ "christoomey/vim-tmux-navigator", lazy = false },
	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", "<leader>Gf", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diff File History" })
			vim.keymap.set("n", "<leader>Gl", "<cmd>DiffviewFileHistory<CR>", { desc = "Diff History All" })
			vim.keymap.set("n", "<leader>Go", "<cmd>DiffviewOpen<CR>", { desc = "Diff View  Open" })
			vim.keymap.set("n", "<leader>Gx", "<cmd>DiffviewClose<CR>", { desc = "Diff View Close" })
		end,
	},

	-- hlchunk seems better
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {},
	-- 	config = function()
	-- 		require("ibl").overwrite({
	-- 			exclude = { filetypes = { "dashboard" } },
	-- 		})
	-- 	end,
	-- },

	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					style = {
						{ fg = "#806d9c" },
						{ fg = "#c21f30" },
					},
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = "─",
					},
					delay = 0,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- TODO: Testing - maybe I'll remove this.
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	config = function() require("nvim-autopairs").setup({}) end,
	-- },
	--

	-- ========== Themes and Visuals ===========

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		config = function()
			vim.cmd("colorscheme catppuccin")
			require("catppuccin").setup({
				integrations = {
					aerial = true,
					blink_cmp = true,
					cmp = true,
					dropbar = {
						enabled = true,
						color_mode = true, -- enable color for kind's texts, not just kind's icons
					},
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f9e2af", bold = true })
			-- vim.api.nvim_set_hl(0, "Visual", { bg = "#45475a" })
		end,
	},

	-- INFO: Disabled themes
	--[[
    { "scottmckendry/cyberdream.nvim" },
    { "folke/tokyonight.nvim", name = "kanagawa" },
    { "rebelot/kanagawa.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "rose-pine/neovim" },
    { "navarasu/onedark.nvim" },
    { "sainnhe/gruvbox-material" },
    { "shaunsingh/nord.nvim" },
    { "olimorris/onedarkpro.nvim" },
    { "sainnhe/sonokai" },
    { "Mofiqul/dracula.nvim" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "neanias/everforest-nvim" },
  ]]

	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	opts = {
	-- 		options = {
	-- 			icons_enabled = true,
	-- 			theme = "auto",
	-- 			component_separators = "|",
	-- 			section_separators = "",
	-- 		},
	-- 	},
	-- },

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>Gd", vim.cmd.Gvdiffsplit, { desc = "[G]it [D]iff :Gvdiffsplit" })
			vim.keymap.set("n", "<leader>Gs", function()
				vim.cmd("vertical Git")
				vim.cmd("vert resize 50")
			end, { desc = "Open Fugitive in vertical split with width 80" })

			vim.keymap.set(
				"n",
				"<leader>GB",
				function() vim.cmd("left vertical Git blame") end,
				{ desc = "Open Fugitive in vertical split with width 80" }
			)

			-- vim.keymap.set("n", "<leader>gs", function()
			-- 	vim.cmd("vertical leftabove Git")
			-- end, { desc = "[G]it [S]how" })
		end,
	},

	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	-- { "wuelnerdotexe/vim-astro" },

	-- ========== Debugger ===========

	-- TODO: maybe later
	-- INFO: nvim in chrome
	-- {
	--   "glacambre/firenvim",
	--   build = function()
	--     vim.fn["firenvim#install"](0)
	--   end,
	-- },
	--
}
