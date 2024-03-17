local Util = require("util")

return function()
	local keymaps = {
		n = {
			["."] = nil,
			["Y"] = "y$",
			["<Enter>"] = "o<Esc>",

			[";"] = "A;<Esc>",
			[","] = "A,<Esc>",

			["<Esc>"] = "<cmd>nohlsearch<CR>",

			["<C-\\>"] = "<cmd>vsplit<CR>",
			["<C-|>"] = "<cmd>split<CR>",

			["[d"] = vim.diagnostic.goto_prev,
			["]d"] = vim.diagnostic.goto_next,

			["<C-h>"] = "<C-w><C-h>",
			["<C-j>"] = "<C-w><C-j>",
			["<C-k>"] = "<C-w><C-k>",
			["<C-l>"] = "<C-w><C-l>",

			["<leader>bf"] = { vim.lsp.buf.format, { desc = "[B]uffer [F]ormat" } },
			["<C-s>"] = ":wa<cr>",

			["<leader>ud"] = {Util.toggle_diagnostic_virtual_text, { desc = "Toggle LSP virtual text"}},
			["<leader>uw"] = {Util.toggle_word_wrap, { desc = "Toggle word wrap"}},

			["<F7>"] = "<cmd>ToggleTerm direction=float<cr>",
		},
	}

	for mode, maps in pairs(keymaps) do
		for k, v in pairs(maps) do
			if type(v) == "string" then
				vim.keymap.set(mode, k, v)
			elseif type(v) == "table" then
				vim.keymap.set(mode, k, v[1], v[2])
			end
		end
	end
end
