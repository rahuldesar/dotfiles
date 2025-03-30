-- USE WHEN NEEDED
-- Disabled DAP for better startup time
local set = vim.keymap.set

return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",

		dependencies = {
			{ "mxsdev/nvim-dap-vscode-js" },
			{ "leoluz/nvim-dap-go" },
			{ "nvim-neotest/nvim-nio" },
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

			-- Breakpoints
			set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
			set("n", "<leader>B", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint (Alt)" })
			set("n", "<leader>dC", function() dap.clear_breakpoints() end, { desc = "DAP: Clear All Breakpoints" })

			set(
				"n",
				"<leader>dB",
				function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
				{ desc = "DAP: Breakpoint with Condition" }
			)
			set(
				"n",
				"<leader>lp",
				function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
				{ desc = "DAP: Set Log Point" }
			)

			-- Execution Control
			set("n", "<leader>dc", dap.continue, { desc = "DAP: Start/Continue debugging" })
			set("n", "<leader>dn", dap.step_over, { desc = "DAP: Next (Step Over)" })
			set("n", "<leader>dN", dap.step_into, { desc = "DAP: Next In (Step Into)" })
			set("n", "<leader>do", dap.step_out, { desc = "DAP: Step Out" })

			set("n", "<leader>d.", dap.step_into, { desc = "DAP: Next In (Step Into)" })
			set("n", "<leader>d,", dap.step_out, { desc = "DAP: Step Out" })

			set("n", "<leader>dr", dap.restart, { desc = "DAP: Restart Debugging" })
			set("n", "<leader>dp", dap.pause, { desc = "DAP: Pause Debugging" })
			set("n", "<leader>dS", dap.close, { desc = "DAP: Stop Debugging" })

			-- UI
			set("n", "<leader>dT", dapui.toggle, { desc = "DAP: Toggle UI" })

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
					program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
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

			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
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
