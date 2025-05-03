return {
	{
		"folke/todo-comments.nvim",
		opts = {
			signs = false, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				DONE = { icon = " ", color = "check" },
				TODO = { icon = " ", color = "todo" },
				HACK = { icon = "󰭙 ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = "󱝾 ", color = "info_duplicate", alt = { "INFO" } },
				ME = { icon = "󰱲 ", color = "me", alt = { "RAHUL" } },
				TEST = { icon = "󰙨", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },

				-- FIX:
				-- DONE:
				-- TODO:
				-- HACK:
				-- WARN:
				-- PERF:
				-- NOTE:
				-- ME:
				-- TEST:
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = false, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#F38BA8" },
				warning = { "DiagnosticWarn", "WarningMsg", "#F9E2AF" },
				todo = { "#CBA6F7" },
				me = { "#F5C2E7" },
				check = { "#A6E3A1" },
				info = { "DiagnosticInfo", "#b4befe" },
				info_duplicate = { "#89B4FA" },
				hint = { "DiagnosticHint", "#94E2D5" },
				default = { "Identifier", "#CBA6F7" },
				test = { "Identifier", "#F5C2E7" },
				--[[
        REFERENCE COLORS
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
        ]]
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
		vim.keymap.set(
			"n",
			"<leader>to",
			-- Trouble todo filter = {tag = {TODO,FIX,FIXME}}
			"<cmd>Trouble todo<cr>",
			{ desc = "todo: Trouble [TO]DO" }
		),

		vim.keymap.set(
			"n",
			"<leader>tn",
			-- Trouble todo filter = {tag = {TODO,FIX,FIXME}}
			"<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>",
			{ desc = "todo: Trouble [TO]DO" }
		),
	},
}
