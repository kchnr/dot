-- local light_theme = "ayu"
-- local dark_theme = "desert"

local function Light()
    vim.opt.background = "light"
    vim.cmd.colorscheme("catppuccin")
end

local function Dark()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("everforest")
end

return {
    -- Keep the themes you like installed…
    { "olimorris/onedarkpro.nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },
    { "altercation/vim-colors-solarized" },
    { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
    { "rose-pine/neovim", name = "rose-pine" },
    { "fugalh/desert.vim" },
    { "sainnhe/everforest" },
    { "rebelot/kanagawa.nvim" },
    { "daschw/leaf.nvim" },
    { "Shatur/neovim-ayu" },

    -- Then, after plugins load, apply ONE scheme:
    {
        "nvim-lua/plenary.nvim", -- any always-loaded plugin works as a hook point
        config = function()
            vim.opt.termguicolors = true

            local function update_background()
                local hour = tonumber(os.date("%H"))
                if hour >= 8 and hour < 20 then
                    Light()
                else
                    Dark()
                end
            end

            update_background()

            local timer = vim.loop.new_timer()
            timer:start(0, 600000, vim.schedule_wrap(update_background))
        end,
    },
}
