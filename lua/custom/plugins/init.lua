-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  -- File Tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
      vim.api.nvim_set_keymap('n', '<leader>nn', ':NvimTreeToggle<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh<CR>', {noremap = true})

      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      -- empty setup using defaults
      require("nvim-tree").setup()

      -- OR setup with some options
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 60,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
  },

  -- Oatmeal assuming Ollama is setup and running for local LLMs
  {
    "dustinblackman/oatmeal.nvim",
    cmd = { "Oatmeal" },
    keys = {
        { "<leader>om", mode = "n", desc = "Start Oatmeal session" },
    },
    opts = {
        backend = "ollama",
        model = "codellama:latest",
    },
  },

    -- nvim-metals
  {
    "scalameta/nvim-metals",
    name = "metals",
    ft = { "scala", "sbt", "java" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<leader>cW", function () require('metals').hover_worksheet() end, desc = "Metals Worksheet" },
      { "<leader>cM", function () require('telescope').extensions.metals.commands() end, desc = "Telescope Metals Commands" },
    },
    config = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
        showInferredType = true,
        superMethodLensesEnabled = true,
      }
      metals_config.init_options.statusBarProvider = "on"
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  }
}
