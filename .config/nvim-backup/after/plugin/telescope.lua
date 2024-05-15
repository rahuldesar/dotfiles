local builtin = require("telescope.builtin")
local map = vim.keymap.set
local themes = require('telescope.themes')


map("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
map("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

map("n", "<leader>ff", builtin.find_files, { desc = "[s]earch [f]iles" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
map('n', '<leader>sc', builtin.colorscheme, { desc = "[S]witch [C]olorscheme" })

map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>st", builtin.treesitter, { desc = "[S]earch [T]reesitter" })
map("n", "<leader>gf", builtin.lsp_document_symbols, { desc = "Symbols" })

map("n", "<leader>sm", builtin.keymaps, { desc = "[S]earch key[m]aps" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sv", builtin.vim_options, { desc = "[S]earch [V]im Options" })
-- Mine


map('n', '<leader>Gc', builtin.git_commits, { desc = "Search [G]it [C]ommits" })
map('n', '<leader>Gb', builtin.git_branches, { desc = "Search [G]it [B]ranches" })
map('n', '<leader>Gs', builtin.git_status, { desc = "Search [G]it [S]tatus" })
map('n', '<leader>Gg', builtin.git_stash, { desc = "Search [G]it Stash" })

require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.6,
        results_width = 0.7,
      },
      vertical = {
        mirror = false,
      },
      width = 0.90,
      height = 0.85,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    current_buffer_fuzzy_find = {
      theme = "ivy",
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

