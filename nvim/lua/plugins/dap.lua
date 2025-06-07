return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("nvim-dap-virtual-text").setup()

			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			-- adapters
			require("dap-python").setup("python3")

			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
				name = "lldb",
			}
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- CHANGE THIS to your path!
					command = "/home/sandesh/.local/share/nvim/mason/bin/codelldb",
					args = { "--port", "${port}" },

					-- On windows you may have to uncomment this:
					-- detached = false,
				},
			}

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation
					args = { "/home/sandesh/.debugger/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}

			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}

			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
			}

			-- configurations
			dap.configurations.cpp = {
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
					runInTerminal = true,

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp

			-- dap.configurations.c = {
			-- 	{
			-- 		name = "Launch",
			-- 		type = "gdb",
			-- 		request = "launch",
			-- 		program = function()
			-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
			-- 		end,
			-- 		cwd = "${workspaceFolder}",
			-- 		runInTerminal = true,
			-- 		stopAtBeginningOfMainSubprogram = false,
			-- 	},
			-- }
			--
			-- dap.configurations.javascript = {
			--   {
			--     type = "pwa-node",
			--     request = "launch",
			--     name = "Launch file",
			--     program = "${file}",
			--     cwd = "${workspaceFolder}",
			--   },
			-- }
			dap.configurations.javascript = {
				{
					name = "Launch",
					type = "node2",
					request = "launch",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					-- For this to work you need to make sure the node process is started with the `--inspect` flag.
					name = "Attach to process",
					type = "node2",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}

			-- keymaps
			vim.keymap.set("n", "<C-F8>", "<cmd> DapToggleBreakpoint <CR>")
			-- vim.keymap.set("n", ";5~", "<cmd> DapToggleBreakpoint <CR>")
			vim.keymap.set("n", "<C-F5>", "<cmd> DapRestartFrame <CR>")
			vim.keymap.set("n", "<F9>", "<cmd> DapContinue <CR>")
			vim.keymap.set("n", "<F8>", "<cmd> DapStepOver <CR>")
			vim.keymap.set("n", "<S-F8>", "<cmd> DapStepOut <CR>")
			vim.keymap.set("n", "<S-F2>", "<cmd> DapTerminate <CR>")
			vim.keymap.set("n", "<F7>", "<cmd> DapStepInto <CR>")
			vim.keymap.set("n", "<leader>lo", "<cmd> lua require('dapui').toggle() <CR>")
			vim.keymap.set("n", "<leader>le", "<cmd> lua require('dapui').eval() <CR>")
			vim.keymap.set(
				"n",
				"<leader>lB",
				"<cmd> lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) <CR>"
			)
		end,
	},
}
