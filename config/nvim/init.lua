-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup plugins
require("lazy").setup({
  -- Theme
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end
  },

  -- File Explorer
  {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
          require("nvim-tree").setup()
          vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
      end
  },

  -- Fuji Finder
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "python", "bash" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
      })
    end
  },

  -- LSP Support
  {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  },

  -- Autocompletion
  {
      "hrsh7th/nvim-cmp",
      dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "L3MON4D3/LuaSnip",
      },
  },

  -- Status Line
  {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
          require('lualine').setup {
              options = { theme = 'catppuccin' }
          }
      end
  },
  
  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  }

})

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.scrolloff = 10
vim.opt.termguicolors = true

-- LSP Setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "bashls", "clangd", "pyright" }
})

local lspconfig = require('lspconfig')
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_lsp.default_capabilities()

-- Setup Loop
local servers = { "lua_ls", "bashls", "clangd", "pyright" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

-- CMP Setup
cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, 
    }, {
      { name = 'buffer' },
    })
})
