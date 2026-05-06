return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 400,
        preset = "modern",
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.add({
            -- git
            { "<leader>g",  group = "git" },
            { "<leader>h",  group = "hunks" },
            -- refactor
            { "<leader>r",  group = "refactor" },
            -- code / lsp
            { "<leader>c",  group = "code" },
            -- find / symbols
            { "<leader>f",  group = "find / symbols" },
            -- view / files
            { "<leader>v",  group = "view / files" },
            -- debug
            { "<leader>d",  group = "debug / db" },
            -- test
            { "<leader>t",  group = "test" },
            -- undo
            { "<leader>u",  group = "undo" },
            -- go-to (LSP navigation, no leader)
            { "g",          group = "go to" },
        })
    end,
}
