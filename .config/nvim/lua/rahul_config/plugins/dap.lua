local set = vim.keymap.set
return {
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			{ "mxsdev/nvim-dap-vscode-js" },
			{ "leoluz/nvim-dap-go" },
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "nvim-telescope/telescope-dap.nvim" },
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "💚", texthl = "", linehl = "", numhl = "" })

			-- set("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>")
			-- set("n", "<S-F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
			-- set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
			-- set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
			-- set("n", "<S-F11>", ":lua require'dap'.step_out()<CR>")
			-- set("n", "<F5>", ":lua require'dap'.continue()<CR>")
			-- set("n", "<F12>", ":lua require'dap'.close()<CR>")

			set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
			set(
				"n",
				"<leader>dB",
				":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				{ desc = "Breakpoint Condition" }
			)
			set("n", "<leader>dn", ":lua require'dap'.step_over()<CR>", { desc = "Step Over" })
			set("n", "<leader>dN", ":lua require'dap'.step_into()<CR>", { desc = "Step Into" })
			set("n", "<leader>do", ":lua require'dap'.step_out()<CR>", { desc = "Step out" })
			-- set("n", "<leader>ds", ":lua require'dap'.start()<CR>", { desc = "DAP start" })
			set("n", "<leader>dc", ":lua require'dap'.continue()<CR>", { desc = "DAP continue" })
			set("n", "<leader>dS", ":lua require'dap'.close()<CR>", { desc = "DAP Stop" })

			set(
				"n",
				"<leader>lp",
				":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
			)
			set("n", "<leader>dT", ":lua require'dapui'.toggle()<CR>", { desc = "DAP UI toggle" })
			-- vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
			-- vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")
			--
			--
			-- vim.keymap.set("n", "<F2>", dap.step_into)
			-- vim.keymap.set("n", "<F3>", dap.step_over)
			-- vim.keymap.set("n", "<F4>", dap.step_out)
			-- vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "DAP Restart." })

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation

					args = {
						os.getenv("HOME")
							.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					}, -- TODO adjust
				},
			}

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- RAHUL: USED MASON TO INSTALL THIS
					command = "/Users/rahuldesar/.local/share/nvim/mason/packages/codelldb/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.adapters.chrome = {
				type = "executable",
				command = "node",
				args = {
					os.getenv("HOME")
						.. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
				}, -- TODO adjust
			}

			-- google-chrome-stable --remote-debugging-port=9222

			-- dap.configurations.javascriptreact = { -- change this to javascript if needed
			--   {
			--     type = "chrome",
			--     request = "attach",
			--     program = "${file}",
			--     cwd = vim.fn.getcwd(),
			--     sourceMaps = true,
			--     protocol = "inspector",
			--     port = 9222,
			--     webRoot = "${workspaceFolder}"
			--   }
			-- }
			--
			--
			--
			-- dap.configurations.typescriptreact = { -- change to typescript if needed
			--   {
			--     type = "chrome",
			--     request = "attach",
			--     program = "${file}",
			--     cwd = vim.fn.getcwd(),
			--     sourceMaps = true,
			--     protocol = "inspector",
			--     port = 9222,
			--     webRoot = "${workspaceFolder}"
			--   }
			-- }
			--
			--
			--
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				delve = {
					path = "dlv",
					initialize_timeout_sec = 20,
					port = "${port}",
					args = {},
					build_flags = {},
					detached = vim.fn.has("win32") == 0,
					cwd = nil,
				},
				tests = {
					verbose = false,
				},
			})

			require("nvim-dap-virtual-text").setup()
			require("dapui").setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^4", -- Recommended
	-- 	ft = { "rust" },
	--
	-- 	config = function()
	-- 		vim.keymap.set("n", "<leader>dR", ":RustLsp debuggables 1 <CR>", { desc = "DAP - RUST" })
	-- 		vim.keymap.set("n", "<leader>pr", ":!cargo run<CR>", { desc = "Play Rust - cargo run" })
	-- 	end,
	-- },
}
