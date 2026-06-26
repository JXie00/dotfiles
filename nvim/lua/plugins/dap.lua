return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui" },
  config = function()
    local dap = require("dap")
    
    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" }
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            -- Utilizing easy-dotnet's built-in target bin discovery
            return require("easy-dotnet").get_debug_dll()
        end,
      },
    }
  end
}
