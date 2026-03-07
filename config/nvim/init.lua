-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key must be set before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.updatetime = 250

-- Plugin setup
require("lazy").setup({

    -- ─── Colorscheme ────────────────────────────────────────────────────
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                transparent_mode = true,
            })
            vim.cmd([[colorscheme gruvbox]])
        end,
    },

    -- ─── Statusline ─────────────────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { theme = "gruvbox" },
            sections = {
                lualine_c = { { "filename", path = 1 } },
            },
        },
    },

    -- ─── File Explorer ──────────────────────────────────────────────────
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
        },
        opts = {
            view = { width = 32 },
            renderer = { group_empty = true },
            filters = { dotfiles = false },
        },
    },

    -- ─── Fuzzy Finder ───────────────────────────────────────────────────
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Find buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({ defaults = { path_display = { "truncate" } } })
            telescope.load_extension("fzf")
        end,
    },

    -- ─── Treesitter ─────────────────────────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua", "vim", "vimdoc",
                "python",
                "html", "css", "javascript", "typescript",
                "c", "cpp",
                "rust",
                "bash", "toml", "json", "yaml", "markdown",
            },
            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            -- Support both old (.configs) and new (main module) nvim-treesitter APIs
            local ok, ts = pcall(require, "nvim-treesitter.configs")
            if ok then
                ts.setup(opts)
            else
                require("nvim-treesitter").setup(opts)
            end
        end,
    },

    -- ─── LSP ────────────────────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",       -- Python
                    "html",          -- HTML
                    "cssls",         -- CSS
                    "ts_ls",         -- JS / TS
                    "clangd",        -- C / C++
                    "rust_analyzer", -- Rust
                },
                automatic_installation = true,
            })

            local caps = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, buf)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
                end
                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gr", vim.lsp.buf.references, "References")
                map("gi", vim.lsp.buf.implementation, "Implementation")
                map("K", vim.lsp.buf.hover, "Hover docs")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
                map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
                map("]d", vim.diagnostic.goto_next, "Next diagnostic")
            end

            -- nvim 0.11+ native API: shared defaults for all servers
            vim.lsp.config("*", {
                capabilities = caps,
                on_attach = on_attach,
            })

            -- clangd-specific overrides
            vim.lsp.config("clangd", {
                cmd = { "clangd", "--background-index", "--clang-tidy" },
            })

            vim.lsp.enable({
                "lua_ls", "pyright", "html", "cssls", "ts_ls", "clangd", "rust_analyzer",
            })
        end,
    },

    -- ─── Formatting ─────────────────────────────────────────────────────
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        keys = {
            { "<leader>f", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
        },
        opts = {
            formatters_by_ft = {
                python     = { "black" },
                html       = { "prettier" },
                css        = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                c          = { "clang_format" },
                cpp        = { "clang_format" },
                rust       = { "rustfmt" },
                lua        = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
    },

    -- ─── Autocompletion ─────────────────────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },

    -- ─── Debugging (DAP) ────────────────────────────────────────────────
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python", -- Python via debugpy
            "jay-babu/mason-nvim-dap.nvim",
        },
        keys = {
            { "<F5>",       function() require("dap").continue() end,          desc = "DAP: Continue" },
            { "<F10>",      function() require("dap").step_over() end,         desc = "DAP: Step over" },
            { "<F11>",      function() require("dap").step_into() end,         desc = "DAP: Step into" },
            { "<F12>",      function() require("dap").step_out() end,          desc = "DAP: Step out" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
            { "<leader>du", function() require("dapui").toggle() end,          desc = "DAP: Toggle UI" },
            { "<leader>dr", function() require("dap").repl.open() end,         desc = "DAP: REPL" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- mason-nvim-dap installs debuggers automatically
            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "codelldb" },
                automatic_installation = true,
            })

            -- Python: use debugpy from mason
            require("dap-python").setup(
                vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
            )

            -- C / C++ / Rust: codelldb
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }
            for _, lang in ipairs({ "c", "cpp", "rust" }) do
                dap.configurations[lang] = {
                    {
                        name        = "Launch",
                        type        = "codelldb",
                        request     = "launch",
                        program     = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd         = "${workspaceFolder}",
                        stopOnEntry = false,
                    },
                }
            end

            -- UI setup
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end
        end,
    },

    -- ─── LaTeX (VimTeX) ─────────────────────────────────────────────────
    {
        "lervag/vimtex",
        lazy = false,
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "-pvc",
                },
            }
            vim.g.vimtex_imaps_enabled = 0
        end,
    },
    -- ─── Quality of Life ────────────────────────────────────────────────
    {
        "numToStr/Comment.nvim",
        keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
        opts = {},
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        opts = {},
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add    = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

}, {
    -- Lazy.nvim options
    ui = { border = "rounded" },
    checker = { enabled = false },
})


-- ─── Keymaps ────────────────────────────────────────────────────────────────
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Indent and stay in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center cursor after jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- at the bottom with your other keymaps
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
