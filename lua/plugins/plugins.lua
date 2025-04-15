return {
  { "RRethy/nvim-base16" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "base16-default-dark",
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
    {
      "neovim/nvim-lspconfig",
      opts = {
          servers = {
          -- Ensure mason installs the server
          clangd = {
              keys = {
              { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
              },
              root_dir = function(fname)
              return require("lspconfig.util").root_pattern(
                  "Makefile",
                  "configure.ac",
                  "configure.in",
                  "config.h.in",
                  "meson.build",
                  "meson_options.txt",
                  "build.ninja"
              )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                  fname
              ) or require("lspconfig.util").find_git_ancestor(fname)
              end,
              capabilities = {
              offsetEncoding = { "utf-16" },
              },
              cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
              },
              init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
              },
          },
          },
          setup = {
          clangd = function(_, opts)
              local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
              require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
              return false
          end,
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
    opts.indent = {
        enable = false,
    }
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

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = opts.sorting.comparators or {}
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
    end,
  }
}
