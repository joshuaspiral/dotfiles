local map = vim.keymap.set

map("n", "<Esc>",      "<cmd>nohlsearch<CR>")
map("n", "<leader>w",  "<cmd>w<CR>",   { desc = "Save" })
map("n", "<leader>q",  "<cmd>q<CR>",   { desc = "Quit" })
map("n", "<leader>Q",  "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centred after jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")

-- Diagnostics
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d",         vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
map("n", "]d",         vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
