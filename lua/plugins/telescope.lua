return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		local base_key = "<leader>f"

		local telescope_mappings = {
			{ base_key .. "h", builtin.help_tags,   { desc = "[F]ind [H]elp" } },
			{ base_key .. "k", builtin.keymaps,     { desc = "[F]ind [K]eymaps" } },
			{ base_key .. "f", builtin.find_files,  { desc = "[F]ind [F]iles" } },
			{ base_key .. "s", builtin.builtin,     { desc = "[F]ind [S]elect Telescope" } },
			{ base_key .. "w", builtin.grep_string, { desc = "[F]ind current [W]ord" } },
			{ base_key .. "g", builtin.live_grep,   { desc = "[F]ind by [G]rep" } },
			{ base_key .. "d", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" } },
			{ base_key .. "r", builtin.resume,      { desc = "[F]ind [R]esume" } },
			{ base_key .. "b", builtin.buffers,    { desc = '[F]ind [B]uffers' } },
			{ base_key .. ".", builtin.oldfiles,    { desc = '[F]ind Recent Files ("." for repeat)' } },
		}

		for _, mapping in pairs(telescope_mappings) do
			vim.keymap.set("n", unpack(mapping))
		end
	end,
}
