-- pull lazy vim
if vim.g.vscode then
	return require("user.vscode_config")
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- install plugins and options
require("vim-options")
require("vim-helpers")
require("help-floating")
require("floating-term")
-- require("lazy").setup("plugins")
local uv = vim.uv
local uname = uv.os_uname()
local hostname = uv.os_gethostname()
local lockfile_path = vim.fn.expand("~/nix/dotfiles/nvim/lazy-lock.json")
local lazy_opts = {}

if not (uname.sysname == "Linux" and hostname == "nixos") then
    lazy_opts.lockfile = lockfile_path
end

require("lazy").setup("plugins", lazy_opts)
require("snipets")
