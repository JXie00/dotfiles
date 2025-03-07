-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end


require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use {   -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
  }

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }


  -- use { "nvim-tree/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons", config = function()
  --     require("nvim-tree").setup {
  --         disable_netrw = true,
  --         hijack_netrw = true,
  --         open_on_tab = false,
  --         hijack_cursor = false,
  --         update_cwd = false,
  --         lsp_diagnostics = true,
  --         update_focused_file = {
  --             enable = true,
  --             update_cwd = false,
  --             ignore_list = {}
  --         },
  --         system_open = {
  --             cmd = nil,
  --             args = {}
  --         },
  --         view = {
  --             width = 30,
  --             side = 'left',
  --             auto_resize = false,
  --             mappings = {
  --                 custom_only = false,
  --                 list = {}
  --             }
  --         }
  --     }
  -- end }
  --

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }

  use {   -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' },
  }

  use {   -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use {   -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }


  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- use 'OmniSharp/omnisharp-vim'

  use 'navarasu/onedark.nvim'                 -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim'             -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'   -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim'                 -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth'                      -- Detect tabstop and shiftwidth automatically
  use 'folke/tokyonight.nvim'
  use 'tpope/vim-surround'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'f-person/git-blame.nvim'
  use 'ThePrimeagen/harpoon'

  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-]>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-[>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end,
  }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
-- install xclip for clipboard to work in nvim
vim.o.clipboard = 'unnamedplus'

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight-moon]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert'

vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_server_type = 'roslyn'
vim.g.OmniSharp_prefer_global_sln = 1
vim.g.OmniSharp_timeout=20
vim.g.OmniSharp_popup_position = 'peek'

vim.g.OmniSharp_popup_options = {
  winblend = 30,
  winhl = 'Normal:Normal,FloatBorder:ModeMsg',
  border = 'rounded'
}
vim.g.OmniSharp_popup_mappings = {
  sigNext = '<C-n>',
  sigPrev = '<C-p>',
  pageDown = { '<C-f>', '<PageDown>' },
  pageUp = { '<C-b>', '<PageUp>' }
}


-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'jk', '<ESC>')

vim.keymap.set('n', '<C-h>', '<C-w>h')

vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-up>', '<c-w>+')
vim.keymap.set('n', '<C-down>', '<c-w>-')
vim.keymap.set('n', '<C-left>', '<c-w>>')
vim.keymap.set('n', '<C-right>', '<c-w><')
vim.keymap.set('n', '<leader>q', ':bd<cr>')
vim.keymap.set('n', '<leader>Q', ':bd!<cr>')
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>')
vim.keymap.set('n', '<leader>tt', ':ToggleTerm<cr>')
vim.keymap.set('n', '<leader>to', ':tabonly<cr>')
vim.keymap.set('n', '<leader>tm', ':tabmove')
vim.keymap.set('n', '<leader>ws', ':split<cr>')
vim.keymap.set('n', '<leader>wS', ':vsplit<cr>')
vim.keymap.set('n', '<leader>wS', ':vsplit<cr>')
vim.keymap.set('n', '<leader>k', ':bnext<cr>')
vim.keymap.set('n', '<leader>j', ':bprevious<cr>')
vim.keymap.set('n', '<C-s>', ':Format<cr>|:w<cr>')
vim.keymap.set('n', '<leader>wc', ':<C-W>q<cr>')
vim.keymap.set('n', '<leader>wC', ':only<cr>')
vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<cr>')


vim.keymap.set('i', '<C-s>', '<ESC>:w<cr>')

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'dracula',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', 'gn', function()
      if vim.wo.diff then return 'gn' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', 'gN', function()
      if vim.wo.diff then return 'gN' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer, { desc = '[] git stage buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[] git undo staged hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = '[] git reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = '[] git preview hunk' })
    map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = '[] git blame current line' })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[] git toggle current line blame' })
    map('n', '<leader>hd', gs.diffthis, { desc = '[] git view diff of current buffer' })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = '[] git view diff of current project' })
    map('n', '<leader>td', gs.toggle_deleted, { desc = '[] git toggle deleted' })
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>,', require('telescope.builtin').commands, { desc = '[ ] List available commands' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })


vim.keymap.set('n', '<leader>.', function()
  jpts = {}
  opts.cwd = vim.fn.expand('%:p:h')
  require 'telescope.builtin'.find_files(opts)
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>ff', function()
  vim.api.nvim_set_current_dir(vim.fn.expand('%:p:h'))
  opts = {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
  end
  require 'telescope.builtin'.find_files(opts)
end, { desc = '[S]earch git [F]iles' })


vim.keymap.set('n', '<leader>fw', function()
  vim.api.nvim_set_current_dir(vim.fn.expand('%:p:h'))
  opts = {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
  end
  require 'telescope.builtin'.grep_string(opts)
end, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>fg', function()
  vim.api.nvim_set_current_dir(vim.fn.expand('%:p:h'))
  opts = {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
  end
  require 'telescope.builtin'.live_grep(opts)
end, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').registers, { desc = '[S]earch [R]egesters' })
vim.keymap.set('n', '<leader>fm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })


vim.keymap.set('n', '<leader>ch', require('telescope.builtin').command_history, { desc = '[S]earch Command history' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_bcommits,
  { desc = 'Lists buffers git commits with diff preview and checks them out on <cr>' })
vim.keymap.set('n', '<leader>gC', require('telescope.builtin').git_commits,
  { desc = 'lists git commits with diff preview, ' })
vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches,
  { desc = 'List all branches with diff view' })
vim.keymap.set('n', '<leader>go', require('telescope.builtin').git_status,
  { desc = 'Lists current changes per file with diff preview and add action' })

local function toggle_move()
  if vim.v.count > 0 then
    -- this does not work (yet?)
    -- require('harpoon.ui').nav_file(vim.v.count)
    return '<cmd>lua require("harpoon.ui").nav_file(vim.v.count)<CR>'
  else
    require('harpoon.mark').toggle_file()
  end
end

vim.keymap.set('n', 'gm', toggle_move, { expr = true },
  { desc = 'Add a mark to harpoon' })

vim.keymap.set('n', '<leader>gm', require('harpoon.ui').toggle_quick_menu,
  { desc = 'open quick harpoon menu' })

vim.keymap.set('n', ']h', require('harpoon.ui').nav_next,
  { desc = 'Nav to next harpoon mark' })

vim.keymap.set('n', '[h', require('harpoon.ui').nav_prev,
  { desc = 'Nav to previous harpoon mark' })


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'c_sharp', 'nix', 'bash', 'java',
    'graphql', 'javascript', 'tsx', 'css', 'json', 'vim' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,       -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,       -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'ge', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>fD', vim.diagnostic.setloclist)


-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('su', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('fo', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>fo', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'rnix', 'bashls', 'jdtls', 'graphql', 'ts_ls',
  'eslint', 'html', 'cssls', 'lua_ls', 'omnisharp', 'tailwindcss'}



-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local pid = vim.fn.getpid()

local omnisharp_bin = "/home/jet/.nix-profile/bin/OmniSharp"


require('lspconfig').omnisharp.setup {
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  on_attach = function(_, bufnr)
    on_attach(_, bufnr)
    _.server_capabilities.semanticTokensProvider = {
      full = vim.empty_dict(),
      legend = {
        tokenModifiers = { "static_symbol" },
        tokenTypes = {
          "comment",
          "excluded_code",
          "identifier",
          "keyword",
          "keyword_control",
          "number",
          "operator",
          "operator_overloaded",
          "preprocessor_keyword",
          "string",
          "whitespace",
          "text",
          "static_symbol",
          "preprocessor_text",
          "punctuation",
          "string_verbatim",
          "string_escape_character",
          "class_name",
          "delegate_name",
          "enum_name",
          "interface_name",
          "module_name",
          "struct_name",
          "type_parameter_name",
          "field_name",
          "enum_member_name",
          "constant_name",
          "local_name",
          "parameter_name",
          "method_name",
          "extension_method_name",
          "property_name",
          "event_name",
          "namespace_name",
          "label_name",
          "xml_doc_comment_attribute_name",
          "xml_doc_comment_attribute_quotes",
          "xml_doc_comment_attribute_value",
          "xml_doc_comment_cdata_section",
          "xml_doc_comment_comment",
          "xml_doc_comment_delimiter",
          "xml_doc_comment_entity_reference",
          "xml_doc_comment_name",
          "xml_doc_comment_processing_instruction",
          "xml_doc_comment_text",
          "xml_literal_attribute_name",
          "xml_literal_attribute_quotes",
          "xml_literal_attribute_value",
          "xml_literal_cdata_section",
          "xml_literal_comment",
          "xml_literal_delimiter",
          "xml_literal_embedded_expression",
          "xml_literal_entity_reference",
          "xml_literal_name",
          "xml_literal_processing_instruction",
          "xml_literal_text",
          "regex_comment",
          "regex_character_class",
          "regex_anchor",
          "regex_quantifier",
          "regex_grouping",
          "regex_alternation",
          "regex_text",
          "regex_self_escaped_character",
          "regex_other_escape",
        },
      },
      range = true,
    }
  end,
  omnisharp = {
    useModernNet = true,
    monoPath = "/home/jet/.nix-profile/bin/mono"
  },
  capabilities = capabilities,
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true
    },
    ImplementTypeOptions = {
      InsertionBehavior = 'WithOtherMembersOfTheSameKind',
      PropertyGenerationBehavior = 'PreferAutoProperties'
    },
    RenameOptions = {
      RenameInComments = true,
      RenameInStrings  = true,
      RenameOverloads  = true
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableDecompilationSupport = true,
      EnableImportCompletion = true,
      locationPaths = {},
      inlayHintsOptions = {
        enableForParameters = true,
        forLiteralParameters = true,
        forIndexerParameters = true,
        forObjectCreationParameters = true,
        forOtherParameters = true,
        suppressForParametersThatDifferOnlyBySuffix = false,
        suppressForParametersThatMatchMethodIntent = false,
        suppressForParametersThatMatchArgumentName = false,
        enableForTypes = true,
        forImplicitVariableTypes = true,
        forLambdaParameterTypes = true,
        forImplicitObjectCreation = true
      }
    }
  }
}


for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Turn on lsp status information
require('fidget').setup()

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer' },
    { name = 'path' },
  },
  -- formatting = {
  --   fields = { 'menu', 'abbr', 'kind' },
  --   expandable_indicator = true,
  --   format = function(entry, item)
  --     local menu_icon = {
  --       nvim_lsp = 'λ',
  --       vsnip = '⋗',
  --       buffer = 'Ω',
  --       path = '🖫',
  --     }
  --
  --     item.menu = menu_icon[entry.source.name]
  --     local e = entry:get_completion_item()
  --     if e.detail ~= nil then
  --       item.kind = item.kind .. '   ' .. e.detail
  --     end
  --
  --     return item
  --   end,
  -- },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
