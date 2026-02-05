return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- Ensure you are using the new main branch
        branch = "main",
        build = ":TSUpdate",
        config = function()
            -- 1. Fix: Use the new module name 'config' instead of 'configs'
            local configs = require("nvim-treesitter.config")

            configs.setup({
                ensure_installed = {
                    "vimdoc",
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "rust",
                    "jsdoc",
                    "bash",
                    "elixir",
                },
                sync_install = false,
                auto_install = true,
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        if lang == "html" then
                            return true
                        end

                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            vim.notify(
                                "File larger than 100KB treesitter disabled for performance",
                                vim.log.levels.WARN,
                                { title = "Treesitter" }
                            )
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = { "markdown" },
                },
            })

            -- 2. Fix: 'get_parser_configs' is deprecated.
            -- Use the new .install() method for custom parsers on the main branch.
            require("nvim-treesitter").install("templ", {
                url = "https://github.com",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            })

            -- 3. Fix: The modern Neovim way to register filetypes
            vim.treesitter.language.register("templ", "templ")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        -- Optional: Some users find better compatibility pinning this to main as well
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
            })
        end,
    },
}
