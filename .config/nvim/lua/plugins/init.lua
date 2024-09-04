return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "charludo/projectmgr.nvim",
    lazy = false,
    option = function()
      require("charludo/projectmgr.nvim").setup {
        {
          autogit = {
            enabled = false,
            command = "git pull --ff-only",
          },
          reopen = false,
          session = {
            enabled = true,
            file = ".session.vim",
          },
          shada = {
            enabled = false,
            file = "main.shada",
          },
          scripts = {
            enabled = true,
            file_startup = "NvimTreeToggle", -- "startup.sh",
            file_shutdown = "shutdown.sh",
          },
        },
      }
    end,
  },

  -- {
  --   "huggingface/llm.nvim",
  --   option = function()
  --     require("llm").setup {
  --       backend = "ollama",
  --       model = "deepseek-coder-v2:16b",
  --       url = "https://api.ai.nocturlab.fr", -- llm-ls uses "/api/generate"
  --       -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
  --       enable_suggestions_on_startup = true,
  --       enable_suggestions_on_files = "*",
  --     }
  --   end,
  -- },

  {
    "David-Kunz/gen.nvim",
    lazy = false,
    config = function()
      require("gen").setup {
        model = "deepseek-coder-v2:16b",
        host = "api.ai.nocturlab.fr",
        port = "443",
        command = function(options)
          local body = { model = options.model, stream = true }
          return "curl --silent --no-buffer -X POST https://"
            .. options.host
            .. ":"
            .. options.port
            .. "/api/chat -d $body"
        end,
      }
    end,
  },
}
