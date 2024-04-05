return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			on_highlights = function(hl, c)
				hl.DiagnosticUnnecessary = {
					fg = c.comment;
				}
			end,
		})

		vim.cmd.colorscheme("tokyonight-night")
	end,
}
