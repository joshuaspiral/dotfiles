return {
	-- 1. LSP Setup (Neovim 0.11 Native API)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local servers = { "lua_ls", "pyright", "clangd", "rust_analyzer" }

			-- Initialize Mason for downloading binaries
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})

			local caps = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(_, buf)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
				end
				map("gd", vim.lsp.buf.definition, "Definition")
				map("gD", vim.lsp.buf.declaration, "Declaration")
				map("gr", vim.lsp.buf.references, "References")
				map("gi", vim.lsp.buf.implementation, "Implementation")
				map("K", vim.lsp.buf.hover, "Hover docs")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
			end

			-- Define global behaviour natively
			vim.lsp.config("*", {
				capabilities = caps,
				on_attach = on_attach,
			})

			-- Activate the servers natively
			vim.lsp.enable(servers)
		end,
	},

	-- 2. Autocompletion
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
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
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

	-- 3. Formatting
	{
		"stevearc/conform.nvim",
		dependencies = {
			"zapling/mason-conform.nvim",
		},
		event = { "BufWritePre" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "black" },
					html = { "prettier" },
					css = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					rust = { "rustfmt" },
					lua = { "stylua" },
				},
				format_on_save = { timeout_ms = 500, lsp_fallback = true },
			})

			-- Auto-install formatters via Mason
			require("mason-conform").setup()
		end,
	},
}
