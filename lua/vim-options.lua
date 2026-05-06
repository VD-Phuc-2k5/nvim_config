vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- paste over highlight word
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over selection (no yank)" })
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"
-- wrap text
-- vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.breakindent = true
-- vim.opt.showbreak = "↳\\"
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client.supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
                break
            end
        end
    end,
})

-- fk llm-ls
local notify_original = vim.notify
vim.notify = function(msg, ...)
    if
        msg
        and (
            msg:match("position_encoding param is required")
            or msg:match("Defaulting to position encoding of the first client")
            or msg:match("multiple different client offset_encodings")
        )
    then
        return
    end
    return notify_original(msg, ...)
end
