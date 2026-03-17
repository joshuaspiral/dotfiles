return {
    {
        "lervag/vimtex",
        lazy = false,
        config = function()
            vim.g.vimtex_view_method   = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                options = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc" },
            }
            vim.g.vimtex_imaps_enabled = 0
        end,
    },
}
