return {
	"Goose97/timber.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("timber").setup({

			log_templates = {
				default = {
					-- Templates with auto_import: when inserting a log statement, the import line is inserted automatically
					-- Applies to batch log statements as well
					-- javascript = {
					--   [[logger.info('hello world')]],
					--   auto_import = [[const logger = require('pino')()]]
					-- }
					javascript = [[console.log("%log_target", %log_target)]],
					typescript = [[console.log("%log_target", %log_target)]],
					jsx = [[console.log("%log_target", %log_target)]],
					tsx = [[console.log("%log_target", %log_target)]],
					lua = [[print("%log_target", %log_target)]],
					ruby = [[puts("%log_target #{%log_target}")]],
					elixir = [[IO.inspect(%log_target, label: "%log_target")]],
					go = [[log.Printf("%log_target: %v\n", %log_target)]],
					rust = [[println!("%log_target: {:#?}", %log_target);]],
					python = [[print(f"{%log_target=}")]],
					c = [[printf("%log_target: %s\n", %log_target);]],
					cpp = [[std::cout << "%log_target: " << %log_target << std::endl;]],
					java = [[System.out.println("%log_target: " + %log_target);]],
					c_sharp = [[Console.WriteLine($"%log_target: {%log_target}");]],
					odin = [[fmt.printfln("%log_target: %v", %log_target)]],
					swift = [[print("%log_target:", %log_target)]],
					kotlin = [[println("%log_target: ${%log_target}")]],
				},
				plain = {
					javascript = [[console.log("%insert_cursor")]],
					typescript = [[console.log("%insert_cursor")]],
					jsx = [[console.log("%insert_cursor")]],
					tsx = [[console.log("%insert_cursor")]],
					lua = [[print("%insert_cursor")]],
					ruby = [[puts("%insert_cursor")]],
					elixir = [[IO.puts(%insert_cursor)]],
					go = [[log.Printf("%insert_cursor")]],
					rust = [[println!("%insert_cursor");]],
					python = [[print(f"%insert_cursor")]],
					c = [[printf("%insert_cursor \n");]],
					cpp = [[std::cout << "%insert_cursor" << std::endl;]],
					java = [[System.out.println("%insert_cursor");]],
					c_sharp = [[Console.WriteLine("%insert_cursor");]],
					odin = [[fmt.println("%insert_cursor")]],
					swift = [[print("%insert_cursor")]],
					kotlin = [[println("%insert_cursor")]],
				},
			},
			batch_log_templates = {
				default = {
					javascript = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
					typescript = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
					jsx = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
					tsx = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
					lua = [[print(string.format("%repeat<%log_target=%s><, >", %repeat<%log_target><, >))]],
					ruby = [[puts("%repeat<%log_target: #{%log_target}><, >")]],
					elixir = [[IO.inspect({ %repeat<%log_target><, > })]],
					go = [[log.Printf("%repeat<%log_target: %v><, >\n", %repeat<%log_target><, >)]],
					rust = [[println!("%repeat<%log_target: {:#?}><, >", %repeat<%log_target><, >);]],
					python = [[print(f"%repeat<{%log_target=}><, >")]],
					c = [[printf("%repeat<%log_target: %s><, >\n", %repeat<%log_target><, >);]],
					cpp = [[std::cout %repeat<<< "%log_target: " << %log_target>< << "\n  " > << std::endl;]],
					java = [[System.out.printf("%repeat<%log_target=%s><, >%n", %repeat<%log_target><, >);]],
					c_sharp = [[Console.WriteLine($"%repeat<%log_target: {%log_target}><, >");]],
					odin = [[fmt.printfln("%repeat<%log_target: %v><, >", %repeat<%log_target><, >)]],
					swift = [[print("%repeat<%log_target: %log_target><, >")]],
					kotlin = [[println("%repeat<%log_target=${%log_target}><, >")]],
				},
			},
			template_placeholders = {
				filename = function()
					return vim.fn.expand("%:t")
				end,
				-- Custom placeholder. For example, this can be used in log templates as %truncated_line
				-- truncated_line = function(ctx)
				--   local line = ctx.log_target:start()
				--   return nvim_buf_get_lines(0, line - 1, line, false)[1]:sub(1, 16)
				-- end,
			},
			-- The string to search for when deleting or commenting log statements
			-- Can be used in log templates as %log_marker placeholder
			log_marker = "🪵",
			-- Controls the flash highlight
			highlight = {
				-- After a log statement is inserted
				on_insert = true,
				-- After a log target is added to a batch
				on_add_to_batch = true,
				-- After a log entry is shown/jumped to in the summary panel
				on_summary_show_entry = true,
				-- The duration of the flash highlight
				duration = 500,
			},
			keymaps = {
				-- Set to false to disable the default keymap for specific actions
				-- insert_log_below = false,
				insert_log_below = "glj",
				insert_log_above = "glk",
				insert_plain_log_below = "glo",
				insert_plain_log_above = "gl<S-o>",
				insert_batch_log = "glb",
				add_log_targets_to_batch = "gla",
				insert_log_below_operator = "g<S-l>j",
				insert_log_above_operator = "g<S-l>k",
				insert_batch_log_operator = "g<S-l>b",
				add_log_targets_to_batch_operator = "g<S-l>a",
			},
			-- Set to false to disable all default keymaps
			default_keymaps_enabled = true,
			log_watcher = {
				enabled = false,
				sources = {},
				-- The length of the preview snippet display as extmarks
				preview_snippet_length = 32,
			},
			log_summary = {
				-- Keymaps for the summary window
				keymaps = {
					-- Set to false to disable the default keymap for specific actions
					-- show_entry = false,
					show_entry = "<CR>",
					jump_to_entry = "o",
					next_entry = "]]",
					prev_entry = "[[",
					close = "q",
				},
				-- Set to false to disable all default keymaps in the summary window
				default_keymaps_enabled = true,
				-- Customize the summary window
				win = {
					-- Control the width of the summary window
					-- They can be a single integer (number of columns)
					-- or a float from 0 to 1 (percentage of the current window width e.g. 0.4 for 40%)
					-- or an array of mixed types
					-- width = {60, 0.4} means "the lesser of 60 columns and 40% of the current window width"
					width = { 60, 0.4 },
					-- Determines where the summary window will be opened: left, right
					position = "left",
					-- Customize the window options
					opts = {},
				},
			},
		})
	end,
}
