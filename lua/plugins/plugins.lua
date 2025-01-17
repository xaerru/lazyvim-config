return {
  { "RRethy/nvim-base16" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "base16-default-dark",
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
            root_dir = function(fname)
                -- Custom rootdir logic: Prefer `.git`, fallback to the current file directory
                local util = require("lspconfig.util")
                return util.find_git_ancestor(fname) or util.path.dirname(fname)
            end,
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
      })
    end,
  },

  {
    "echasnovski/mini.surround",
    recommended = true,
    keys = function(_, keys)
      local opts = LazyVim.opts("mini.surround")
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },

  {
    "CRAG666/betterTerm.nvim",
    opts = {
      position = "bot",
      size = 15,
    },
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "aoueidhtns;qjkxbmwvz",
    },
  },

  {
    "CRAG666/code_runner.nvim",
    opts = {
      mode = "term",
      startinsert = true,
      term = {
        position = "vsplit",
      },
      filetype = {
        c = "gcc -lm $file && ./a.out && rm a.out",
        cpp = "g++ -std=c++17 $file && ./a.out && rm a.out",
      },
    },
  },

  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup({
        runner_ui = {
          interface = "split",
        },
        template_file = "~/cp/template.cpp",
        split_ui = {
          position = "right",
          relative_to_editor = true,
          total_width = 0.3,
          vertical_layout = {
            { 1, "tc" },
            { 1, { { 1, "so" }, { 1, "eo" } } },
            { 1, { { 1, "si" }, { 1, "se" } } },
          },
          total_height = 0.4,
          horizontal_layout = {
            { 2, "tc" },
            { 3, { { 1, "so" }, { 1, "si" } } },
            { 3, { { 1, "eo" }, { 1, "se" } } },
          },
        },

        compile_command = {
          cpp = { exec = "g++", args = { "-Wall", "-std=c++17", "$(FNAME)", "-o", "$(FNOEXT)" } },
        },

        run_command = {
          cpp = { exec = "./$(FNOEXT)" },
        },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "clang-format",
      },
    },
  },
}
