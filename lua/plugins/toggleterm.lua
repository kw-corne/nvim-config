local prompt_term_cmd_key = "<leader>tc"
local exec_curr_cmd_key = "<F5>"

local curr_cmd = nil

local function prompt_term_cmd()
	curr_cmd = vim.fn.input("Cmd: ")
end

local function exec_curr_cmd()
	if curr_cmd == nil then
		print("Set a command first using " .. prompt_term_cmd_key)
		return
	end

	local cmd_to_exec = "TermExec cmd=\"" .. curr_cmd .. "\" direction=float"
	vim.api.nvim_command("wa")
	vim.api.nvim_command(cmd_to_exec)
end

vim.keymap.set("n", prompt_term_cmd_key, prompt_term_cmd)
vim.keymap.set("n", exec_curr_cmd_key, exec_curr_cmd)

return {
	'akinsho/toggleterm.nvim',
	version = "*",
	init = function()
		require("toggleterm").setup {
			on_create = function(t)
				vim.o.foldcolumn = "0"
				vim.o.signcolumn = "no"

				local toggle = function() t:toggle() end
				vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle float terminal" })
			end,
		}
	end,
}
