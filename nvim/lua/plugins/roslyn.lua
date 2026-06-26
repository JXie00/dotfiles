return {
  "seblj/roslyn.nvim",
  ft = "cs",
  opts = {
    -- Points to the Roslyn executable automatically if configured correctly
    config = {
      settings = {
        ["csharp|background_analysis"] = {
          dotnet_analyzer_diagnostics_scope = "fullSolution",
          dotnet_compiler_diagnostics_scope = "fullSolution",
        },
      },
    },
  },
}
