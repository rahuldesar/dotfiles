return {

	"nvim-lualine/lualine.nvim",

	config = function()
		-- Eviline config for lualine
		-- Author: shadmansaleh
		-- Credit: glepnir
		local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#1E1E2E', -- Catppuccin base
  fg       = '#CDD6F4', -- Catppuccin text
  yellow   = '#F9E2AF', -- Catppuccin yellow
  cyan     = '#94E2D5', -- Catppuccin teal
  darkblue = '#89B4FA', -- Catppuccin blue
  green    = '#A6E3A1', -- Catppuccin green
  orange   = '#FAB387', -- Catppuccin peach
  violet   = '#CBA6F7', -- Catppuccin mauve
  magenta  = '#F5C2E7', -- Catppuccin pink
  blue     = '#89B4FA', -- Catppuccin blue
  red      = '#F38BA8', -- Catppuccin red
}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = { left = "", right = "" },
				section_separators = "",

				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return "▊"
			end,
			color = { fg = colors.magenta }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		})

		ins_left({
			-- mode component
			function()
				if vim.fn.mode() == "n" then
					return "󰚌"
				elseif vim.fn.mode() == "V" or vim.fn.mode() == "v" or vim.fn.mode() == "CTRL-V" then
					return "󰈈"
				elseif vim.fn.mode() == "i" then
					return ""
				elseif vim.fn.mode() == "R" or vim.fn.mode() == "Rx" then
					return ""
				elseif vim.fn.mode() == "c" then
					return ""
				else
					return ""
				end
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					["␖"] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					["␓"] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.cyan },
			},
		})

		ins_left({
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.orange, gui = "bold" },
		})

		ins_left({
			function()
				local reg = vim.fn.reg_recording()
				if reg ~= "" then
					return "RECORDING @" .. reg
				end
				return ""
			end,
			color = { fg = colors.red, gui = "bold" },
		})

		ins_left({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins_left({
			function()
				return "%="
			end,
		})

		ins_left({
			"aerial",
			-- The separator to be used to separate symbols in status line.
			sep = " > ",

			-- The number of symbols to render top-down. In order to render only 'N' last
			-- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
			-- be used in order to render only current symbol.
			depth = nil,

			-- When 'dense' mode is on, icons are not rendered near their symbols. Only
			-- a single icon that represents the kind of current symbol is rendered at
			-- the beginning of status line.
			dense = false,

			-- The separator to be used to separate symbols in dense mode.
			dense_sep = ".",

			-- Color the symbol icons.
			colored = true,
			color = { fg = colors.green, gui = "bold" },
		})

		-- ins_left({
		-- 	function()
		-- 		local current_node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
		-- 		while current_node do
		-- 			if current_node:type() == "function_declaration" or current_node:type() == "method_declaration" then
		-- 				return " " .. vim.treesitter.get_node_text(current_node:child(1), 0)
		-- 			end
		-- 			current_node = current_node:parent()
		-- 		end
		-- 		return ""
		-- 	end,
		-- 	cond = function()
		-- 		local ok, _ = pcall(require, "nvim-treesitter")
		-- 		return ok and require("nvim-treesitter.parsers").has_parser()
		-- 	end,
		-- 	color = { fg = colors.green, gui = "bold" },
		-- })

		-- Add components to right sections

		-- ins_right({
		-- 	-- filesize component
		-- 	"filesize",
		-- 	cond = conditions.buffer_not_empty,
		-- })

		-- ins_right({
		-- 	"o:encoding", -- option component same as &encoding in viml
		-- 	fmt = string.upper, -- I'm not sure why it's upper case either ;)
		-- 	cond = conditions.hide_in_width,
		-- 	color = { fg = colors.green, gui = "bold" },
		-- })
		--

		ins_right({
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end

				local all_clients = ""
				local num_clients = #clients
				for i, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						all_clients = all_clients .. "[" .. client.name .. "]"
						if i < num_clients then
							all_clients = all_clients .. ","
						end
					end
				end
				return all_clients
			end,
			icon = " LSP:",
			color = { fg = "#ffffff" },
		})

		-- ins_right({
		-- 	-- Lsp server name .
		-- 	function()
		-- 		local msg = "0 Lsp Connected"
		-- 		local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
		-- 		local clients = vim.lsp.get_clients()
		--
		-- 		local client_count = 0
		-- 		for i, client in ipairs(clients) do
		-- 			client_count = client_count + 1
		-- 		end
		-- 		if client_count == 0 then
		-- 			return msg
		-- 		else
		-- 			return client_count
		-- 		end
		-- 	end,
		-- 	icon = ": ",
		-- 	color = { fg = "#ffffff", gui = "bold" },
		-- })

		ins_right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
			color = { fg = colors.green },
		})

		ins_right({ "location" })

		ins_right({ "progress", color = { fg = colors.fg, gui = "bold" }, padding = { left = 0, right = 1 } })

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.magenta },
			padding = { left = 0 },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
