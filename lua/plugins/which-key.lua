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
            { "<leader>g",  group = "git" },
            { "<leader>gf", desc = "format file" },
            { "<leader>r",  group = "refactor" },
            { "<leader>rn", desc = "rename symbol" },
            { "<leader>c",  group = "code" },
            { "<leader>ca", desc = "code action" },
            { "<leader>f",  group = "find / symbols" },
            { "<leader>fm", desc = "document symbols" },
        })
    end,
}
