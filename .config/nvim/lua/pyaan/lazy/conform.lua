return {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
        { "<leader>f", function() require("conform").format() end, mode = "n", desc = "Format file or range" },
    },
    opts = {
        notify_on_error = true,
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            go = { "goimports", "gofumpt" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            cpp = { "clang_format" },
            c = { "clang_format" },
            rust = { "rustfmt" },
        },
    },
} 