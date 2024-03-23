return {
	-- "catppuccin/nvim",
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	init = function()
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_foreground = "mix"
		vim.g.gruvbox_material_dim_inactive_windows = 0
		vim.g.gruvbox_material_float_style = "dim"
	end,
	config = function()
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
