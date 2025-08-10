local function ColorMyPencils(scheme)
    scheme = scheme or "tokyonight" -- pick your default here
    vim.cmd.colorscheme(scheme)
end

return {
    -- Keep the themes you like installed…
    { "folke/tokyonight.nvim", priority = 1000 }, -- load early
    { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
    { "rose-pine/neovim", name = "rose-pine" },
    { "fugalh/desert.vim" },
    { "erikbackman/brightburn.vim" },

    -- Then, after plugins load, apply ONE scheme:
    {
        "nvim-lua/plenary.nvim", -- any always-loaded plugin works as a hook point
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            ColorMyPencils("tokyonight") -- or "gruvbox" / "rose-pine" / "desert"
        end,
    },
}
