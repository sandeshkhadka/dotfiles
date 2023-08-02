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
      command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
      name = 'lldb'
    }

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      -- port = 9229,
      executable = {
        command = "node",
        args = { "/home/sandesh/.debuggers/js-debug/src/dapDebugServer.js", "${port}" },
      }
    }


    -- configurations
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp

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
        type = 'pwa-node',
        request = 'launch',
        name = "Launch file",
        runtimeExecutable = "deno",
        runtimeArgs = {
          "run",
          "--inspect-wait",
          "--allow-all"
        },
        program = "${file}",
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
      },
    }


    -- keymaps
    vim.keymap.set('n', "<leader>lb", "<cmd> DapToggleBreakpoint <CR>")
    vim.keymap.set('n', "<leader>lr", "<cmd> DapContinue <CR>")
    vim.keymap.set('n', "<leader>lo", "<cmd> lua require('dapui').toggle() <CR>")
    vim.keymap.set('n', "<leader>le", "<cmd> lua require('dapui').eval() <CR>")
    vim.keymap.set('n', "<leader>lB",
      "<cmd> lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) <CR>")
  end
  },
}
