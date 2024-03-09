return {
	"nvim-treesitter/nvim-treesitter",
	build        = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config       = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"markdown",
				"vim",
				"vimdoc",
				"bash",
				"lua",
				"rust",
				"python",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		}
	end,
}
