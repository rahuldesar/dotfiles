-- @TODO:  Rewrite lsp config remove `lsp-zero` and switch `nvim-cmp` with `blink.cmp`
-- @INFO: Read 'you might not need lsp-zero'

local lsp = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = false,
	manage_nvim_cmp = false,
	suggest_lsp_servers = true,
})

local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

local lspconfig = require("lspconfig")

lsp.configure("pyright", {
	settings = {
		python = {
			pythonPath = "/opt/homebrew/bin/python3.9",
			-- analysis = {
			-- 	typeCheckingMode = "off", -- Disables strict type checking
			-- 	reportArgumentType = "off", -- Disables argument type reporting
			-- 	reportLiteralParameterTypeMismatch = "none", -- Disables this specific error
			-- },
		},
	},
})
local luasnip = require("luasnip")
luasnip.config.setup({})

local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

require("luasnip.loaders.from_vscode").lazy_load()
--load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "/Users/rahuldesar/.config/nvim-snippets/snippets/" } })

-- local cmp = require("cmp")
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args) luasnip.lsp_expand(args.body) end,
-- 	},
-- 	completion = { completeopt = "menu,menuone,noinsert" },
-- 	---@diagnostic disable-next-line: missing-fields
--
-- 	formatting = {
-- 		format = function(entry, vim_item)
-- 			-- Kind icons
-- 			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
-- 			-- Source
-- 			vim_item.menu = ({
-- 				luasnip = "[LuaSnip]",
-- 				buffer = "[Buffer]",
-- 				nvim_lsp = "[LSP]",
-- 				nvim_lua = "[Lua]",
-- 				latex_symbols = "[LaTeX]",
-- 			})[entry.source.name]
-- 			return vim_item
-- 		end,
-- 	},
--
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 		["<C-Space>"] = cmp.mapping.complete({}),
--
-- 		["<C-n>"] = cmp.mapping.select_next_item(),
-- 		["<C-p>"] = cmp.mapping.select_prev_item(),
--
-- 		-- for snippets
-- 		["<C-l>"] = cmp.mapping(function()
-- 			if luasnip.expand_or_locally_jumpable() then
-- 				luasnip.expand_or_jump()
-- 			end
-- 		end, { "i", "s" }),
-- 		["<C-h>"] = cmp.mapping(function()
-- 			if luasnip.locally_jumpable(-1) then
-- 				luasnip.jump(-1)
-- 			end
-- 		end, { "i", "s" }),
--
-- 		["<C-d>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-u>"] = cmp.mapping.scroll_docs(-4),
-- 	}),
-- 	sources = {
-- 		{ name = "luasnip" },
-- 		{ name = "nvim_lsp" },
-- 		{ name = "path" },
-- 	},
-- })

-- cmp.setup.filetype({ "sql" }, {
-- 	sources = {
-- 		{ name = "vim-dadbod-completion" },
-- 		{ name = "buffer" },
-- 	},
-- })

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.diagnostic.config({
		virtual_text = { current_line = true, severity = vim.diagnostic.severity.WARN },
		virtual_lines = { severity = vim.diagnostic.severity.ERROR },
	})

	vim.keymap.set("", "[d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

	vim.keymap.set("n", "<leader>vd", require("telescope.builtin").diagnostics, opts)
	--
	-- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]o to [D]efinition" })
	vim.keymap.set("n", "<leader>gd", require("telescope.builtin").lsp_definitions, { desc = "[G]o to [D]efinition" })
	-- TODO: use telescope for this too
	vim.keymap.set(
		"n",
		"<leader>gD",
		function() vim.cmd("vsplit | lua vim.lsp.buf.definition()") end,
		{ desc = "[G]o to [D]efinition in vertical split", noremap = true }
	)

	vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "[G]o to [R]eferences" })

	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("i", "<C-hh>", function() vim.lsp.buf.signature_help() end, opts)

	vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, { desc = "[G]o to [I]mplementations" })
	vim.keymap.set(
		"n",
		"<leader>gI",
		require("telescope.builtin").lsp_implementations,
		{ desc = "[G]o to [I]mplementations" }
	)

	-- vim.keymap.set("n", "<leader>vws", function()
	-- 	vim.lsp.buf.workspace_symbol()
	-- end, opts)

	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "[C]ode [A]ction" })

	-- buf_nnoremap { "<space>ca", vim.lsp.buf.code_action }
	--  telescope_mapper("gr", "lsp_references", nil, true)
	-- telescope_mapper("gI", "lsp_implementations", nil, true)
	-- telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
	-- telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

	vim.keymap.set("n", "<leader>ra", function() vim.lsp.buf.rename() end, opts)

	vim.keymap.set("n", "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
	-- vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

	vim.keymap.set("n", "<C-\\>", ":vsp<CR>", { noremap = true, silent = true, desc = "Split Vertical" })

	-- TODO: make this work only on ts files
	require("twoslash-queries").attach(client, bufnr)
	vim.keymap.set("n", "<leader>ct", "<cmd>TwoslashQueriesEnable<CR>", {})
	vim.keymap.set("n", "<leader>wt", "<cmd>TwoslashQueriesInspect<CR>", {})
	vim.keymap.set("n", "<leader>dt", "<cmd>TwoslashQueriesRemove<CR>", {})
end)

-- require("lspconfig").tsserver.setup({
-- 	on_attach = function(client, bufnr)
-- require("twoslash-queries").attach(client, bufnr)
-- 	end,
-- })

lsp.set_sign_icons({
	-- error = '',
	-- warn = '',
	-- hint = '',
	-- info = ''
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "»",
})

-- lsp.nvim_workspace()
--

lsp.setup()
