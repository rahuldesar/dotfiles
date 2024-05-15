return {
  --  ========= LSP and  all the good stuff =============

  { "mbbill/undotree" },
  { "wuelnerdotexe/vim-astro" },
  { "theprimeagen/harpoon" },
  { "tpope/vim-rhubarb" }, -- If fugitive.vim is the Git, rhubarb.vim is the Hub
  { "folke/neodev.nvim",         opts = {} },
  { "nvim-treesitter/playground" },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "javascript",
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
    config = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- Lsp
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "typescript-language-server",
          }
        }
      },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
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
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "html"
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },

  { "lewis6991/gitsigns.nvim" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
  },

  -- ======== Quality of Life ==========

  { "christoomey/vim-tmux-navigator",      lazy = false },
  { "sindrets/diffview.nvim" },
  { "akinsho/toggleterm.nvim",             version = "*", config = true },
  { "numToStr/Comment.nvim" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",  opts = {} },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- ========== Themes and Visuals ===========

  -- { "mhinz/vim-startify" }
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- opts = {
    --   color_overrides = {
    --     latte = { base = "#dce0e8", mantle = "#dce0e8" },
    --     frappe = { base = "#232634", mantle = "#232634" },
    --     macchiato = { base = "#181926", mantle = "#181926" },
    --     mocha = { base = "#11111b", mantle = "#11111b" },
    --   },
    -- },
  },
  { "norcalli/nvim-colorizer.lua" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
    },
  },
  { "tpope/vim-fugitive" },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },



  -- ========== Debugger ===========
  --
  { "mfussenegger/nvim-dap" },
  { "mxsdev/nvim-dap-vscode-js" },
  -- {"leoluz/nvim-dap-go"},
  { "rcarriga/nvim-dap-ui" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "nvim-telescope/telescope-dap.nvim" },
  { "folke/todo-comments.nvim" },
  { "metakirby5/codi.vim" },
}
