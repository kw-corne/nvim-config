return {
	"blazkowolf/gruber-darker.nvim",
	lazy = false,
	priority = 1000,
	dependencies = { "rktjmp/lush.nvim" },
	config = function()
		vim.cmd.colorscheme("gruber-darker")
	end,
}

