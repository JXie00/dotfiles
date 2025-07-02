-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local map = vim.keymap.set

-- Normal mode remapping
--vim.keymap.set('n', 'm', 'h') -- 'n' moves left
--vim.keymap.set('n', 'n', 'j') -- 'e' moves down
--vim.keymap.set('n', 'e', 'k') -- 'i' moves up
--vim.keymap.set('n', 'i', 'l') -- 'o' moves right

-- Visual mode remapping
--vim.keymap.set('v', 'm', 'h') -- 'n' moves left
--vim.keymap.set('v', 'n', 'j') -- 'e' moves down
--vim.keymap.set('v', 'e', 'k') -- 'i' moves up
--vim.keymap.set('v', 'i', 'l') -- 'o' moves right

-- Other useful remaps if needed
--vim.keymap.set('n', 'h', 'n') -- Keep 'h' for next search match
--vim.keymap.set('v', 'h', 'n') -- Same for visual mode

--vim.keymap.del("n", "<leader>/")

vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>wS", "<C-W>v", { desc = "Split Window Right", remap = true })

vim.keymap.set("n", "<leader>tt", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

vim.keymap.set("n", "<leader>k", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>j", "<cmd>bprevious<cr>")

vim.keymap.set("n", "<leader>?", "<cmd>FzfLua oldfiles<cr>", { desc = "[?] Find recently opened files" })

vim.keymap.set(
  "n",
  "<leader><space>",
  "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
  { desc = "[ ] Find existing buffers" }
)

vim.keymap.set("n", "<leader>,", "<cmd>FzfLua commands<cr>", { desc = "[ ] List available commands", remap = true })

vim.keymap.set("n", "<leader>/", "<Cmd>FzfLua grep_curbuf<CR>", { desc = "[ ] Current buffer fuzzy", remap = true })

vim.keymap.set(
  "n",
  "<leader>.",
  LazyVim.pick("files", { root = false, cwd = vim.fn.expand("%:p:h") }),
  { desc = "Find Files (cwd)", remap = true }
)

vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "[S]earch [H]elp", remap = true })

vim.keymap.set(
  "n",
  "<leader>fw",
  LazyVim.pick("grep_string", { word_match = "-w" }),
  { desc = "Word (Root Dir)", remap = true }
)
vim.keymap.set("n", "<leader>fg", LazyVim.pick("live_grep"), { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>fG", LazyVim.pick("live_grep", { root = false }), { desc = "[S]earch by [G]rep (CWD)" })

vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "[S]earch [D]iagnostics" })
vim.keymap.set(
  "n",
  "<leader>fD",
  "<cmd>FzfLua diagnostics_workspace<cr>",
  { desc = "[S]earch [D]iagnostics workspace" }
)
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua registers<cr>", { desc = "[S]earch [R]egesters" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<cr>", { desc = "[S]earch [M]arks" })

vim.keymap.set("n", "<leader>ch", "<cmd>FzfLua command_history<cr>", { desc = "[S]earch Command history" })
vim.keymap.set(
  "n",
  "<leader>gc",
  "<cmd>FzfLua git_bcommits<cr>",
  { desc = "Lists buffers git commits with diff preview and checks them out on <cr>" }
)
vim.keymap.set("n", "<leader>gC", "<cmd>FzfLua git_commits<cr>", { desc = "lists git commits with diff preview, " })
vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", { desc = "List all branches with diff view" })
vim.keymap.set(
  "n",
  "<leader>go",
  "<cmd>FzfLua git_status<cr>",
  { desc = "Lists current changes per file with diff preview and add action" }
)

map("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })

map("n", "su", "<cmd>FzfLua lsp_references<cr>", { desc = "[G]oto [R]eferences" })
map("n", "fo", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "[D]ocument [S]ymbols" })
map("n", "<leader>fo", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "[W]orkspace [S]ymbols" })

-- Diagnostic keymaps
vim.keymap.set("n", "gE", vim.diagnostic.goto_prev)
vim.keymap.set("n", "ge", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

map("n", "<leader>bk", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
