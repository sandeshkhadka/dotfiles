return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
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
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
        name = 'lldb'
      }

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = { "/home/sandesh/.debugger/js-debug/src/dapDebugServer.js", "${port}" },
        }
      }

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
      }


      -- configurations
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            -- os.execute("echo 0 | sudo -S tee /proc/sys/kernel/yama/ptrace_scope")
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          -- stopOnEntry = true,
          runInTerminal = true
        },
      }

      dap.configurations.c = dap.configurations.cpp
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
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          processId = require 'dap.utils'.pick_process,
        },
      }

      -- keymaps
      vim.keymap.set('n', "<C-F8>", "<cmd> DapToggleBreakpoint <CR>")
      vim.keymap.set('n', "<C-F5>", "<cmd> DapRestartFrame <CR>")
      vim.keymap.set('n', "<F9>", "<cmd> DapContinue <CR>")
      vim.keymap.set('n', "<F8>", "<cmd> DapStepOver <CR>")
      vim.keymap.set('n', "<S-F8>", "<cmd> DapStepOut <CR>")
      vim.keymap.set('n', "<S-F2>", "<cmd> DapTerminate <CR>")
      vim.keymap.set('n', "<F7>", "<cmd> DapStepInto <CR>")
      vim.keymap.set('n', "<leader>lo", "<cmd> lua require('dapui').toggle() <CR>")
      vim.keymap.set('n', "<leader>le", "<cmd> lua require('dapui').eval() <CR>")
      vim.keymap.set('n', "<leader>lB",
        "<cmd> lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) <CR>")
    end
  },
}
