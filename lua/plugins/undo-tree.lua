return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
		vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus, { desc = "Focus undo tree" })
	end,
}
