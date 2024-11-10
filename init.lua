vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.mouse = "a"

vim.opt.showmode = false

vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

vim.diagnostic.config {
  float = { border = "rounded" },
}

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.undofile = true

vim.opt.cmdheight = 0

-- Lines from cursor to bottom
vim.opt.scrolloff = 10

-- Small keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<Enter>", "o<Esc>")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", ";", "A;<Esc>")
vim.keymap.set("n", ",", "A,<Esc>")
vim.keymap.set("n", "<C-s>", ":wa<CR>")
vim.keymap.set({ "n", "v" }, "iq", 'i"')
vim.keymap.set({ "n", "v" }, "aq", 'a"')

-- Quickfix list
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- Toggle virtual text
local virtual_text_enabled = true
vim.keymap.set("n", "<leader>ud", function()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config { virtual_text = virtual_text_enabled }
end, { desc = "Toggle line diagnostics" })

vim.keymap.set(
  "n",
  "<leader>uw",
  function() vim.opt.wrap = not vim.opt.wrap end,
  { desc = "Toggle word wrap" }
)

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Set PowerShell 7 as default terminal in Windows
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Split creation
vim.keymap.set("n", "<C-\\>", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<C-\\>", "<cmd>hsplit<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Install Lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  }
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end -- @diagnostic disable-next-line: undefined field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  "tpope/vim-sleuth",

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd "colorscheme cyberdream" end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },

      spec = {
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable "make" == 1 end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
      vim.keymap.set(
        "n",
        "<leader>f.",
        builtin.oldfiles,
        { desc = '[F]ind Recent Files ("." for repeat)' }
      )
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind buffers" })
      vim.keymap.set(
        "n",
        "<leader>fo",
        builtin.live_grep,
        { desc = "[F]ind in [O]pen files by grep" }
      )

      vim.keymap.set(
        "n",
        "<leader>fc",
        function() builtin.find_files { cwd = vim.fn.stdpath "config" } end,
        { desc = "[F]ind [C]onfig files" }
      )
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  { "Bilal2453/luvit-meta", lazy = true },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("<leader>lR", require("telescope.builtin").lsp_references, "[L]sp show [R]eferences")
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          map(
            "<leader>ds",
            require("telescope.builtin").lsp_document_symbols,
            "[D]ocument [S]ymbols"
          )
          map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
          )
          map("<leader>lr", vim.lsp.buf.rename, "[L]sp [R]ename")
          map("<leader>la", vim.lsp.buf.code_action, "[L]sp code [A]tion", { "n", "x" })
          map(
            "<leader>ld",
            function() vim.schedule(vim.diagnostic.open_float) end,
            "[L]sp show [D]iagnostic"
          )
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
          then
            local highlight_augroup =
              vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds {
                  group = "kickstart-lsp-highlight",
                  buffer = event2.buf,
                }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map(
              "<leader>th",
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
              end,
              "[T]oggle Inlay [H]ints"
            )
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local servers = {
        lua_ls = {
          -- cmd = {...},
          -- filetypes = {...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      local lspconfig = require "lspconfig"
      for server, config in pairs(servers or {}) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { "stylua" })
      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
      }

      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            server.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConfirmInfo" },
    keys = {
      {
        "<leader>bf",
        function() require("conform").format { async = true, lsp_format = "fallback" } end,
        mode = "",
        desc = "[B]uffer [F]ormat",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function()
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        -- python = { "isort", "black" },
      },
    },
  },

  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = { preset = "default" },
      highlight = { use_nvim_cmp_as_default = true },
      nerd_font_variant = "mono",
    },
    opts_extend = { "sources.completion.enabled_providers" },
  },

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  {
    "echasnovski/mini.nvim",
    config = function() require("mini.ai").setup { n_lines = 500 } end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "powershell",
        "lua",
        "luadoc",
        "diff",
        "html",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      -- TODO: TreeSitter textobjects stuff
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup {
        provider_selector = function() return { "treesitter", "indent" } end,
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function macro_rec()
        local register = vim.fn.reg_recording()

        if register and register ~= "" then
          if vim.g.have_nerd_font then
            return " @" .. register
          else
            return "rec@" .. register
          end
        end

        return ""
      end

      require("lualine").setup {
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { macro_rec, "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        options = {
          theme = "auto",
        },
      }
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open Oil" })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash",
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    init = function()
      require("toggleterm").setup {
        on_create = function(t)
          vim.o.foldcolumn = "0"
          vim.o.signcolumn = "no"

          local toggle = function() t:toggle() end
          vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle float terminal" })
        end,
      }

      local current_cmd = nil

      local function run_current_cmd()
        print(current_cmd)
        if current_cmd == nil or current_cmd == "" then
          print "No command has been set"
          return
        end

        local c = 'TermExec cmd="' .. current_cmd .. '" direction=float'
        vim.api.nvim_command "wa"
        vim.api.nvim_command(c)
      end

      vim.keymap.set(
        "n",
        "<leader>tc",
        function() current_cmd = vim.fn.input "Command: " end,
        { desc = "Set current [T]erminal [C]ommand" }
      )
      vim.keymap.set("n", "<F5>", run_current_cmd, { desc = "Run the currently set command" })
      vim.keymap.set("n", "<F7>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open terminal" })
    end,
  },

  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "<leader>/",
      },
      opleader = {
        line = "<leader>/",
      },
    },
  },

  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    config = function()
      vim.keymap.set("n", "<leader><leader>a", "<cmd>Grapple tag<CR>", { desc = "[T]ag file" })
      vim.keymap.set("n", "<leader><leader>d", "<cmd>Grapple untag<CR>", { desc = "[U]ntag file" })
      vim.keymap.set(
        "n",
        "<leader><leader>t",
        "<cmd>Grapple open_tags<CR>",
        { desc = "[T]ags open" }
      )
      for i = 1, 9 do
        vim.keymap.set(
          "n",
          "<leader>" .. i,
          "<cmd>Grapple select index=" .. i .. "<CR>",
          { desc = "Select index " .. i }
        )
      end
    end,
  },
}
