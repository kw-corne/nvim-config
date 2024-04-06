return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.files").setup {
			windows = {
				preview = true,
			}
		}
		local minifiles_toggle = function()
			if not MiniFiles.close() then
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
			end
		end
		vim.keymap.set("n", "<leader>e", minifiles_toggle)

		local statusline = require("mini.statusline")
		statusline.setup()

		local curr_macro_reg = nil

		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				curr_macro_reg = vim.fn.reg_recording()
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				curr_macro_reg = ""
			end,
		})

		local function section_macro()
			if not curr_macro_reg or curr_macro_reg == "" then
				return ""
			else
				return (" @%s"):format(curr_macro_reg)
			end
		end

		local function active_config()
			local _, mode_hl  = MiniStatusline.section_mode({ trunc_width = 120 })
			local git         = MiniStatusline.section_git({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename    = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location    = MiniStatusline.section_location({ trunc_width = 75 })
			local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })
			local macro       = section_macro()

			return MiniStatusline.combine_groups({
				{ hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
				'%<', -- Mark general truncate point
				{ hl = 'MiniStatuslineFilename', strings = { filename } },
				{ hl = 'MiniStatuslineDevinfo',  strings = { macro } },
				'%=', -- End left alignment
				{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
				{ hl = mode_hl,                  strings = { search, location } },
			})
		end

		MiniStatusline.config = {
			use_icons = true,
			set_vim_settings = true,

			content = {
				active = active_config,
				inactive = active_config,
			}
		}

		statusline.section_mode = function()
			return ""
		end

		statusline.section_location = function()
			return "%l|%L"
		end
	end
}
