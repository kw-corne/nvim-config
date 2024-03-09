require("options")()
require("keymaps")()
require("autocommands")()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	"nvim-lua/plenary.nvim",

	require("plugins.ufo"),
	require("plugins.guess_indent"),
	require("plugins.neoscroll"),
	require("plugins.arrow"),
	require("plugins.toggleterm"),
	require("plugins.neotree"),
	require("plugins.autopairs"),
	require("plugins.indent-blankline"),
	require("plugins.colorscheme"),
	require("plugins.leap"),
	require("plugins.telescope"),
	require("plugins.mini"),
	require("plugins.comment"),
	require("plugins.gitsigns"),
	require("plugins.which-key"),
	require("plugins.lspconfig"),
	require("plugins.cmp"),
	require("plugins.todo-comments"),
	require("plugins.treesitter"),
})
