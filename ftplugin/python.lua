local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_lsp.default_capabilities()

vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = vim.fs.root(0, {
        ".git",
        "pyproject.toml",
        "setup.py",
        "requirements.txt",
    }),
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

vim.lsp.enable("pyright")
