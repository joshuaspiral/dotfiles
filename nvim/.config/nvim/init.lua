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

-- Leader must be set before plugins load
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")

-- lazy.nvim auto-scans lua/plugins/*.lua
require("lazy").setup("plugins", {
    ui      = { border = "rounded" },
    checker = { enabled = false },
})
