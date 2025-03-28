return {
	--  ========= LSP and  all the good stuff =============
	{
		"mbbill/undotree",
		config = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) end,
	},

	{ "tpope/vim-rhubarb" },

	-- TEST:  testing mini
	-- { "tpope/vim-surround" },

	{ "folke/neodev.nvim", opts = {} },

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"html",
				"javascript",
				"rust",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function() pcall(require("nvim-treesitter.install").update({ with_sync = true })) end,
	},

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
							{ "golangci-lint", version = "v1.47.0" },
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

	{
		"evanleck/vim-svelte",
		branch = "main",

		dependencies = {
			"othree/html5.vim",
			"pangloss/vim-javascript",
		},
	},

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

	-- { "numToStr/Comment.nvim", opts = {}, lazy = false },

	-- ======== Quality of Life ==========

	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "sindrets/diffview.nvim" },
	-- { "numToStr/Comment.nvim" },

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
	--   "windwp/nvim-autopairs",
	--   config = function()
	--     require("nvim-autopairs").setup({})
	--   end,
	-- },
	--

	-- ========== Themes and Visuals ===========

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
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
			-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]how" });

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
	--
	--
	{ "wuelnerdotexe/vim-astro" },

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
