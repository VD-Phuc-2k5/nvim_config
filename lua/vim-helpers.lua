-- all vim helper functions here

vim.keymap.set("n", "<leader>ce", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics > 0 then
		local message = diagnostics[1].message
		vim.fn.setreg("+", message)
		print("Copied diagnostic: " .. message)
	else
		print("No diagnostic at cursor")
	end
end, { noremap = true, silent = true, desc = "Copy diagnostic message" })

-- go to errors in a file :/
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
-- copy current file path (absolute) into clipboard
vim.keymap.set("n", "<leader>cp", function()
	local filepath = vim.fn.expand("%:p")
	vim.fn.setreg("+", filepath) -- Copy to Neovim clipboard
	vim.fn.system("echo '" .. filepath .. "' | pbcopy") -- Copy to macOS clipboard
	print("Copied: " .. filepath)
end, { desc = "Copy absolute path to clipboard" })

-- open the current file in browser
vim.keymap.set("n", "<leader>ob", function()
	local file_path = vim.fn.expand("%:p") -- get the current file path
	if file_path ~= "" then
		local cmd
		if vim.fn.has("mac") == 1 then
			local firefox_installed = vim.fn.system("which /Applications/Firefox.app/Contents/MacOS/firefox")
			if firefox_installed == "" then
				cmd = "open -a 'Google Chrome' " .. file_path
			else
				cmd = "open -a 'Firefox' " .. file_path
			end
		else
			local firefox_path = vim.fn.system("which firefox"):gsub("\n", "")
			local has_firefox = firefox_path ~= ""
			if has_firefox then
				cmd = "google-chrome " .. file_path
			end
			cmd = "firefox " .. file_path
		end
		os.execute(cmd .. " &")
	else
		print("No file to open")
	end
end, { desc = "Open current file in browser" })

-- set language based on vim mode
-- requires macism https://github.com/laishulu/macism
-- recommend installing it by brew
local sysname = vim.loop.os_uname().sysname
-- Show folder/dir structure
vim.api.nvim_create_user_command("ShowTree", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines
	local width = math.floor(editor_width * 0.6)
	local height = math.floor(editor_height * 0.9)

	local row = math.floor((editor_height - height) / 2)
	local col = math.floor((editor_width - width) / 2)
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
		style = "minimal",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)
	local job_id = vim.fn.jobstart(
		{ "bash", "-c", [[tree -L 10 -I "bin|obj|debug|target|__pycache__|node_modules|.git"]] },
		{
			stdout_buffered = true,
			stderr_buffered = true,
			on_stdout = function(_, data)
				if data then
					for _, line in ipairs(data) do
						vim.api.nvim_buf_set_lines(buf, -1, -1, true, { line })
					end
				end
			end,
			on_stderr = function(_, data)
				if data then
					for _, line in ipairs(data) do
						if line ~= "" then
							vim.api.nvim_buf_set_lines(buf, -1, -1, true, { "[ERR] " .. line })
						end
					end
				end
			end,
			on_exit = function()
				-- vim.api.nvim_win_close(win, true)
			end,
		}
	)
	print("Job ID: " .. job_id)
end, {})

vim.keymap.set("n", "<leader>vt", ":ShowTree<CR>", { desc = "Show directory tree in floating window" })
