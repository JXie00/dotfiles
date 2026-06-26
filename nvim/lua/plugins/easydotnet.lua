return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    require("easy-dotnet").setup({
      -- Overrides default terminal runner options if required
      terminal_host = "toggleterm", 
    })
    
    -- Quick keymaps
    vim.keymap.set("n", "<leader>dr", "<cmd>Dotnet run<cr>", { desc = ".NET Run" })
    vim.keymap.set("n", "<leader>db", "<cmd>Dotnet build<cr>", { desc = ".NET Build" })
    vim.keymap.set("n", "<leader>dt", "<cmd>Dotnet test<cr>", { desc = ".NET Test" })
  end;
}
