local prefix = "<leader>u"
return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	config = function()
		local transparent = require "transparent"
		transparent.setup {
			extra_groups = {
				"NormalFloat",
				"NvimTreeNormal",
				"FloatBorder",
			},
		}
		transparent.clear_prefix "BufferLine"
		transparent.clear_prefix "NeoTree"
		transparent.clear_prefix "lualine"
		transparent.clear_prefix "MiniStatusline"
		transparent.clear_prefix "MiniFiles"
		transparent.clear_prefix "Telescope"
		transparent.clear_prefix "WhichKey"
	end,
	keys = {
		{ prefix .. "T", "<cmd>TransparentToggle<CR>", desc = "Toggle transparency" },
	},
}
