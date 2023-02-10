vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'ellisonleao/gruvbox.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use { "nvim-telescope/telescope-file-browser.nvim" }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use "glepnir/lspsaga.nvim"

  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- use {
  --   'zbirenbaum/copilot.lua',
  --   event = 'VimEnter',
  --   config = function()
  --     vim.defer_fn(function()
  --       require('copilot').setup({
  --         panel = {
  --           enabled = true,
  --           auto_refresh = false,
  --           keymap = {
  --             jump_prev = "[[",
  --             jump_next = "]]",
  --             accept = "<C-j>",
  --             refresh = "gr",
  --             open = "gl"
  --           },
  --         },
  --         suggestion = {
  --           enabled = true,
  --           auto_trigger = true,
  --           debounce = 75,
  --           keymap = {
  --             accept = "<C-a>",
  --             accept_word = false,
  --             accept_line = false,
  --             next = "<M-]>",
  --             prev = "<M-[>",
  --             dismiss = "<C-]>",
  --           },
  --         },
  --         filetypes = {
  --           yaml = false,
  --           markdown = false,
  --           help = false,
  --           gitcommit = false,
  --           gitrebase = false,
  --           hgcommit = false,
  --           svn = false,
  --           cvs = false,
  --           ["."] = false,
  --         },
  --         copilot_node_command = 'node', -- Node.js version must be > 16.x
  --         server_opts_overrides = {},
  --       })
  --     end, 100)
  --   end,
  -- }

  -- use {
  --   'zbirenbaum/copilot-cmp',
  --   after = {'copilot.lua'},
  --   config = function ()
  --     require('copilot_cmp').setup()
  --   end
  -- }


  use 'navarasu/onedark.nvim'

  use 'lewis6991/gitsigns.nvim'

  use 'arkav/lualine-lsp-progress'

  use 'wakatime/vim-wakatime'

  use 'ThePrimeagen/vim-be-good'

  use 'nyoom-engineering/oxocarbon.nvim'

  use 'dense-analysis/neural'

  use 'MunifTanjim/nui.nvim'
  use 'ElPiloto/significant.nvim'

  use {
    'rareitems/printer.nvim',
    config = function()
      require('printer').setup({
        keymap = "gl"
      })
    end
  }

  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      -- Snippet Collection (Optional)
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'github/copilot.vim'

  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'simrat39/rust-tools.nvim'

end)
