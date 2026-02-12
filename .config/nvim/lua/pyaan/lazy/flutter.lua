return {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- Optional: for better UI
    },
    config = function()
        require("flutter-tools").setup({
            lsp = {
                color_render = true, -- Shows color swatches in code
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    -- This makes the LSP faster by excluding specific folders
                    analysisExcludedFolders = {
                        vim.fn.expand("$HOME/.pub-cache"),
                    },
                },
            },
            dev_log = {
                enabled = true,
                open_cmd = "tabedit", -- Opens logs in a new tab
            },
        })
    end,
}
