return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio", -- required by dap-ui
    "theHamsta/nvim-dap-virtual-text", -- inline variable values
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters.coreclr = {
      type = "executable",
      command = "/home/jet/.nix-profile/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        name = "Attach to .NET isolated worker",
        type = "coreclr",
        request = "attach",
        -- Filtered picker so you only see dotnet processes (used only for the
        -- manual <leader>da path; azfunc attaches on its own).
        processId = function()
          return require("dap.utils").pick_process({ filter = "dotnet" })
        end,
      },
    }

    -- ── UI ────────────────────────────────────────────────────────────────
    dapui.setup()
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,

      highlight_changed_variables = true,
      highlight_new_as_changed = true,

      show_stop_reason = true,

      commented = false,

      virt_text_pos = "eol",
    })

    -- Auto open/close the UI on any session. These hook dap's own events, so
    -- they fire for azfunc-started sessions too, not just <leader>da.
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", {
      text = "🔴",
      texthl = "DiagnosticError",
    })

    vim.fn.sign_define("DapStopped", {
      text = "▶",
      texthl = "DiagnosticWarn",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "",
      texthl = "DiagnosticError",
    })

    -- ── Keymaps ───────────────────────────────────────────────────────────
    -- NOTE: your original mapped `q` in normal mode, which clobbers Vim's
    -- macro-recording. Moved to <leader>dq. Change back if that was intentional.
    vim.keymap.set("n", "<leader>dq", function()
      dap.terminate()
      dap.clear_breakpoints()
    end, { desc = "Terminate and clear breakpoints" })

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over (alt)" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Run to cursor" })
    vim.keymap.set("n", "<leader>da", function()
      dap.run(dap.configurations.cs[1])
    end, { desc = "Attach to .NET isolated worker" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
    vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
    vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })
    vim.keymap.set("n", "<leader>dh", function()
      require("dap.ui.widgets").hover()
    end)

    vim.keymap.set("n", "<leader>dp", function()
      require("dap.ui.widgets").preview()
    end)

    -- UI-specific extras
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
    vim.keymap.set({ "n", "v" }, "<leader>de", function()
      dapui.eval(nil, { enter = true })
    end, { desc = "Evaluate expression under cursor" })
  end,
}
