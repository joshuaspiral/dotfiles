return {
	-- Syntax highlighting + structural editing
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"python",
				"html",
				"css",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"rust",
				"bash",
				"toml",
				"json",
				"yaml",
				"markdown",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			local ok, ts = pcall(require, "nvim-treesitter.configs")
			if ok then
				ts.setup(opts)
			else
				require("nvim-treesitter").setup(opts)
			end
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({ defaults = { path_display = { "truncate" } } })
			telescope.load_extension("fzf")
		end,
	},

	-- File explorer
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

	-- Comments
	{
		"numToStr/Comment.nvim",
		keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
		opts = {},
	},

	-- Auto-close brackets
	-- {
	--     "windwp/nvim-autopairs",
	--     event = "InsertEnter",
	--     opts = {},
	-- },

	-- Surround: ys, cs, ds  (e.g. ysiw" → surround word with quotes)
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
}
