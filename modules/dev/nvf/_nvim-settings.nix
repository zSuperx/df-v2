{pkgs, ...}: {
  config.vim = {
    viAlias = true;
    vimAlias = true;

    extraLuaFiles = [./extra-setup.lua];

    options = {
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      clipboard = "unnamedplus";
    };

    keymaps = [
      { key = ";"; mode = ["n" "v"]; action = ":lua vim.api.nvim_feedkeys(':', 'n', true)<CR>"; }
      { key = "<Esc>"; mode = "n"; action = ":if v:hlsearch | noh | endif<CR>"; }
      { key = "<C-c>"; mode = "n"; action = ":%y+<CR>"; }
      { key = "<Esc>"; mode = "t"; action = "<C-\\><C-n>"; }
      { key = "<Tab>"; mode = "n"; action = ":bnext<CR>"; }
      { key = "<S-Tab>"; mode = "n"; action = ":bprev<CR>"; }
      { key = "<C-[>"; mode = "n"; action = ":po<CR>"; }
      { key = "<C-j>"; mode = "n"; action = ":m +1<CR>"; }
      { key = "<C-k>"; mode = "n"; action = ":m -2<CR>"; }
    ];

    lineNumberMode = "number";

    lsp = {
      enable = true;
      formatOnSave = false;
      trouble.enable = true;
      lspSignature.enable = true;
      otter-nvim.enable = true;
      nvim-docs-view.enable = true;
    };

    projects.project-nvim.enable = true;

    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };

    fzf-lua.enable = true;

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      nix = {
        enable = true;
        lsp.enable = true;
      };
      markdown = {
        enable = true;
        format.type = "prettierd";
        extensions.markview-nvim.enable = true;
      };

      # Languages that are enabled in the maximal configuration.
      lua.enable = true;
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      ts.enable = true;
      python = {
        enable = true;
        format = {
          enable = true;
          type = "black";
        };
      };
      rust = {
        enable = true;
        crates.enable = true;
        lsp.enable = true;
      };
    };

    diagnostics.config = {
      virtual_text = true;
      virtual_lines = true;
    };

    autopairs.nvim-autopairs.enable = true;

    autocomplete.nvim-cmp = {
      enable = true;
      sourcePlugins = [
        "cmp-path"
      ];
    };
    snippets.luasnip.enable = true;

    tabline = {
      nvimBufferline = {
        enable = true;
        setupOpts = {
          options.sort_by = "insert_at_end";
          options.indicator.style = "underline";
        };
      };
    };

    telescope.enable = true;
    terminal.toggleterm.enable = true;

    # VISUAL STUFFS

    utility = {
      multicursors.enable = true;
      yazi-nvim.enable = true;
    };
    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    visuals = {
      nvim-scrollbar.enable = true;
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
      indent-blankline.enable = true;
    };
    highlight = {
      Normal = {
        ctermbg = "NONE";
        bg = "NONE";
      };

      Visual = {
        bg = "NvimDarkGrey4";
      };
    };
    statusline = {
      lualine = {
        enable = true;
      };
    };
    minimap.codewindow.enable = true; # lighter, faster, and uses lua for configuration
    dashboard.alpha.enable = true;
    notes.todo-comments.enable = true;
    theme.transparent = true;
    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer = {
        enable = true;
        setupOpts.fileTypes = {
          "*" = {};
        };
      };
      illuminate.enable = true;
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          go = [
            "90"
            "130"
          ];
        };
      };
      fastaction.enable = true;
    };

    comments = {
      comment-nvim = {
        enable = true;
        mappings = {
          toggleSelectedBlock = " /";
          toggleCurrentLine = " /";
        };
      };
    };

    extraPlugins = {
      "guess-indent" = {
        package = pkgs.vimPlugins.guess-indent-nvim;
        setup = ''
          require("guess-indent").setup()
        '';
      };

      "neogit" = {
        package = pkgs.vimPlugins.neogit;
        setup = ''
          require("neogit").setup()
        '';
      };
    };
  };
}
