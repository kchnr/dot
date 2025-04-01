return {
    "tpope/vim-projectionist",
    config = function()
        vim.g.projectionist_heuristics = {
            ["*"] = {
                ["src/*.ts"] = {
                    alternate = "test/{}.spec.ts",
                },
                ["test/*.spec.ts"] = {
                    alternate = "src/{}.ts",
                },
                ["src/*.js"] = {
                    alternate = "test/{}.spec.js",
                },
                ["test/*.spec.js"] = {
                    alternate = "src/{}.js",
                },
            },
        }
    end,
}
