return function()
	-- g
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- o
	vim.o.foldcolumn = '0' -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.o.cmdheight = 0
	vim.o.wrap = false
	vim.o.clipboard = "unnamedplus"
	vim.o.breakindent = true
	vim.o.undofile = true
	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.o.mouse = "a"
	vim.o.updatetime = 250
	vim.o.timeoutlen = 300
	vim.o.completeopt = "menuone,noselect"
	vim.o.termguicolors = true
	vim.o.hlsearch = true
	vim.o.undofile = true
	vim.o.splitright = true
	vim.o.splitdown = true
	vim.o.showmode = false
	vim.o.cursorline = true
	vim.o.scrolloff = 10
	vim.o.relativenumber = true
	vim.o.number = true
	vim.o.colorcolumn = "100"

	-- wo
	vim.wo.number = true
	vim.wo.signcolumn = "yes"
end
