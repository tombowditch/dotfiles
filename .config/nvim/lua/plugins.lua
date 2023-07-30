require("lazy").setup(
  {
    -- plugins
    {
      "rose-pine/neovim",
      name = "rose-pine"
    },
    -- {
    --     "navarasu/onedark.nvim",
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         require('onedark').setup {
    --             style = 'deep'
    --         }
    --         require('onedark').load()
    --     end
    -- },
    { "ellisonleao/gruvbox.nvim" },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    },
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup {}
      end
    },
    {
      "akinsho/bufferline.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    -- {
    --   "nvim-tree/nvim-tree.lua",
    --   dependencies = { "nvim-tree/nvim-web-devicons" },
    --   lazy = false
    --   -- config = function()
    --   --     require("nvim-tree").setup {}
    --
    --   --     vim.api.nvim_create_autocmd({"VimEnter"}, {
    --   --         callback = open_nvim_tree
    --   --     })
    --   -- end
    -- },

    { "lewis6991/gitsigns.nvim" },
    { "arkav/lualine-lsp-progress" },
    { "wakatime/vim-wakatime" },
    { "ThePrimeagen/vim-be-good" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "MunifTanjim/nui.nvim" },
    { "ElPiloto/significant.nvim" },
    { "akinsho/toggleterm.nvim" },
    {
      "VonHeikemen/lsp-zero.nvim",
      dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets"
      }
    },
    {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    },
    { "github/copilot.vim" },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("trouble").setup {}
      end
    },
    { "simrat39/rust-tools.nvim" },
    {
      "windwp/nvim-spectre",
      config = function()
        require("spectre").setup {}
      end
    },
    {
      "jose-elias-alvarez/null-ls.nvim"
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim"
      },
      cmd = "Neotree"
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash"
        },
        {
          "S",
          mode = { "n", "o", "x" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter"
        },
        {
          "r",
          mode = "o",
          function()
            require("flash").remote()
          end,
          desc = "Remote Flash"
        },
        {
          "R",
          mode = { "o", "x" },
          function()
            require("flash").treesitter_search()
          end,
          desc = "Flash Treesitter Search"
        },
        {
          "<c-s>",
          mode = { "c" },
          function()
            require("flash").toggle()
          end,
          desc = "Toggle Flash Search"
        }
      },
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
        end
      }
    },
    {
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end,
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        presets = {
          inc_rename = true,
          bottom_search = true,
          lsp_doc_border = true,
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        }
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      }
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup {
          background_colour = "#000000",
        }
      end
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
  },
  {}
)

