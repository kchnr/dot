return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local builtin = require("telescope.builtin")

        require("telescope").setup({
            defaults = {
                path_display = { "smart" },
            },
            extensions = {
                fzf = {}, -- Uses the C-sorter for speed
            },
        })
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope [F]ind [F]iles" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope [F]ile [G]rep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope [F]ind [B]uffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope [F]ind [H]elp tags" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope git files" })
    end,
}
