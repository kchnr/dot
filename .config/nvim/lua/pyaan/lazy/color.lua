local function ColorMyPencils(scheme)
    scheme = scheme or "leaf"
    vim.cmd.colorscheme(scheme)
end

return {
    -- Keep the themes you like installed…
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },
    { "altercation/vim-colors-solarized" },
    { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
    { "rose-pine/neovim", name = "rose-pine" },
    { "fugalh/desert.vim" },
    { "sainnhe/everforest" },
    { "rebelot/kanagawa.nvim" },
    { "daschw/leaf.nvim" },

    -- Then, after plugins load, apply ONE scheme:
    {
        "nvim-lua/plenary.nvim", -- any always-loaded plugin works as a hook point
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "light"
            ColorMyPencils("everforest")
        end,
    },
}
