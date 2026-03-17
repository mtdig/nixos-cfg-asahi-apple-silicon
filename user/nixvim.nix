{ pkgs, config, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # ── Global options ──────────────────────────────────────────────
    opts = {
      number = true;
      relativenumber = true;
      syntax = "on";
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
      clipboard = "unnamedplus";
      signcolumn = "yes";
      cursorline = true;
      mouse = "a";
      undofile = true;
      ignorecase = true;
      smartcase = true;
      guicursor = "";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # ── Colorscheme ─────────────────────────────────────────────────
    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    # ── Keymaps (ThePrimeagen style) ────────────────────────────────
    keymaps = [
      # netrw / file explorer
      { mode = "n"; key = "<leader>pv"; action = "<cmd>Ex<cr>"; options.desc = "Open netrw"; }

      # move selected lines in visual mode
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.desc = "Move selection down"; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; options.desc = "Move selection up"; }

      # join lines without moving cursor
      { mode = "n"; key = "J"; action = "mzJ`z"; options.desc = "Join lines (keep cursor)"; }

      # centered scrolling
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options.desc = "Scroll down (centered)"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options.desc = "Scroll up (centered)"; }

      # centered search
      { mode = "n"; key = "n"; action = "nzzzv"; options.desc = "Next search (centered)"; }
      { mode = "n"; key = "N"; action = "Nzzzv"; options.desc = "Prev search (centered)"; }

      # LSP restart
      { mode = "n"; key = "<leader>zig"; action = "<cmd>LspRestart<cr>"; options.desc = "Restart LSP"; }

      # paste over selection without yanking
      { mode = "x"; key = "<leader>p"; action = ''"_dP''; options.desc = "Paste (no yank)"; }

      # yank to system clipboard
      { mode = [ "n" "v" ]; key = "<leader>y"; action = ''"+y''; options.desc = "Yank to clipboard"; }
      { mode = "n"; key = "<leader>Y"; action = ''"+Y''; options.desc = "Yank line to clipboard"; }

      # delete to void register
      { mode = [ "n" "v" ]; key = "<leader>d"; action = ''"_d''; options.desc = "Delete (no yank)"; }

      # escape from insert with ctrl-c
      { mode = "i"; key = "<C-c>"; action = "<Esc>"; options.desc = "Escape"; }

      # disable Q
      { mode = "n"; key = "Q"; action = "<nop>"; options.desc = "Disable Q"; }

      # better window navigation
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Window left"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Window down"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Window up"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Window right"; }

      # harpoon2
      { mode = "n"; key = "<leader>hm"; action.__raw = "function() require('harpoon'):list():add() end"; options.desc = "Harpoon mark file"; }
      { mode = "n"; key = "<C-e>"; action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end"; options.desc = "Harpoon menu"; }
      { mode = "n"; key = "<leader>hn"; action.__raw = "function() require('harpoon'):list():next() end"; options.desc = "Harpoon next"; }
      { mode = "n"; key = "<leader>hp"; action.__raw = "function() require('harpoon'):list():prev() end"; options.desc = "Harpoon prev"; }
      { mode = "n"; key = "<leader>h1"; action.__raw = "function() require('harpoon'):list():select(1) end"; options.desc = "Harpoon file 1"; }
      { mode = "n"; key = "<leader>h2"; action.__raw = "function() require('harpoon'):list():select(2) end"; options.desc = "Harpoon file 2"; }
      { mode = "n"; key = "<leader>h3"; action.__raw = "function() require('harpoon'):list():select(3) end"; options.desc = "Harpoon file 3"; }
      { mode = "n"; key = "<leader>h4"; action.__raw = "function() require('harpoon'):list():select(4) end"; options.desc = "Harpoon file 4"; }

      # toggle word wrap
      { mode = "n"; key = "<leader>w"; action = "<cmd>set wrap!<cr>"; options.desc = "Toggle word wrap"; }
    ];

    # ── Plugins ─────────────────────────────────────────────────────

    plugins = {
      # ─ UI ─
      web-devicons.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      indent-blankline.enable = true;
      noice.enable = true;
      notify.enable = true;
      which-key.enable = true;

      # ─ Navigation ─
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = { action = "find_files"; options.desc = "Find files"; };
          "<leader>fg" = { action = "live_grep"; options.desc = "Live grep"; };
          "<leader>fb" = { action = "buffers"; options.desc = "Buffers"; };
          "<leader>fh" = { action = "help_tags"; options.desc = "Help tags"; };
          "<leader>fr" = { action = "oldfiles"; options.desc = "Recent files"; };
          "<leader>fc" = { action = "git_commits"; options.desc = "Git commits"; };
          "<leader>fs" = { action = "git_status"; options.desc = "Git status"; };
        };
      };

      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      neo-tree = {
        enable = true;
        settings.close_if_last_window = true;
      };

      # ─ Treesitter ─
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          ensure_installed = [
            "bash"
            "c"
            "cpp"
            "css"
            "dockerfile"
            "go"
            "gomod"
            "hcl"
            "html"
            "java"
            "javascript"
            "json"
            "kotlin"
            "lua"
            "markdown"
            "markdown_inline"
            "nix"
            "python"
            "query"
            "regex"
            "rust"
            "scala"
            "sql"
            "terraform"
            "toml"
            "tsx"
            "typescript"
            "vim"
            "vimdoc"
            "yaml"
          ];
        };
      };

      # ─ LSP ─
      lsp = {
        enable = true;
        servers = {
          # nix
          nil_ls.enable = true;

          # lua
          lua_ls.enable = true;

          # python
          pyright.enable = true;
          ruff.enable = true;

          # rust
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };

          # go
          gopls.enable = true;

          # typescript / javascript
          ts_ls.enable = true;
          eslint.enable = true;

          # c/c++
          clangd.enable = true;

          # java
          jdtls = {
            enable = true;
            cmd = [
              "jdtls"
              "-data" "${config.home.homeDirectory}/.cache/jdtls/workspace"
            ];
          };

          # docker
          dockerls.enable = true;
          docker_compose_language_service.enable = true;

          # terraform
          terraformls.enable = true;

          # yaml / json / toml
          yamlls.enable = true;
          jsonls.enable = true;
          taplo.enable = true;

          # html / css / tailwind
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;

          # bash
          bashls.enable = true;

          # markdown
          marksman.enable = true;

          # ansible
          ansiblels = {
            enable = true;
            package = null;
          };

          # helm
          helm_ls = {
            enable = true;
            package = null;
          };

          # sql
          sqls = {
            enable = true;
            package = null;
          };

          # kotlin
          kotlin_language_server.enable = true;

          # tex
          texlab.enable = true;
        };

        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gr" = "references";
            "K" = "hover";
            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
            "<leader>f" = "format";
          };
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>e" = "open_float";
          };
        };
      };

      # ─ Completion ─
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;

      # ─ Formatting ─
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [ "ruff_format" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            javascriptreact = [ "prettier" ];
            typescriptreact = [ "prettier" ];
            json = [ "prettier" ];
            yaml = [ "prettier" ];
            markdown = [ "prettier" ];
            html = [ "prettier" ];
            css = [ "prettier" ];
            nix = [ "nixfmt" ];
            rust = [ "rustfmt" ];
            go = [ "gofmt" ];
            sh = [ "shfmt" ];
            bash = [ "shfmt" ];
          };
        };
      };

      # ─ Linting ─
      lint = {
        enable = true;
        lintersByFt = {
          python = [ "ruff" ];
          javascript = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
          sh = [ "shellcheck" ];
          bash = [ "shellcheck" ];
        };
      };

      # ─ Git ─
      gitsigns.enable = true;
      fugitive.enable = true;

      # ─ Misc ─
      comment.enable = true;
      nvim-autopairs.enable = true;
      todo-comments.enable = true;
      trouble.enable = true;
      flash.enable = true;
    };

    # ── OpenCode AI integration ────────────────────────────────────
    extraPlugins = [
      pkgs.vimPlugins.opencode-nvim
    ];

    extraConfigLua = ''
      vim.o.autoread = true

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        lsp = {
          enabled = true,
        },
      }

      -- Custom terminal provider for opencode (no snacks/tmux needed)
      local opencode_buf = nil
      local opencode_cmd = "opencode --port"

      local function get_win()
        if opencode_buf and vim.api.nvim_buf_is_valid(opencode_buf) then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == opencode_buf then
              return win
            end
          end
        end
        return nil
      end

      local function buf_alive()
        return opencode_buf and vim.api.nvim_buf_is_valid(opencode_buf)
      end

      local function open_split()
        vim.cmd("botright vsplit")
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, opencode_buf)
        vim.cmd("wincmd p")
        return win
      end

      local provider = {
        name = "terminal",
        cmd = opencode_cmd,
        start = function(self)
          if buf_alive() then return end
          vim.cmd("botright vnew")
          vim.fn.termopen(self.cmd)
          opencode_buf = vim.api.nvim_get_current_buf()
          vim.cmd("wincmd p")
        end,
        stop = function(_)
          if buf_alive() then
            vim.api.nvim_buf_delete(opencode_buf, { force = true })
          end
          opencode_buf = nil
        end,
        toggle = function(self)
          local win = get_win()
          if win then
            vim.api.nvim_win_close(win, true)
          elseif buf_alive() then
            open_split()
          else
            self:start()
          end
        end,
        show = function(self)
          if not get_win() and buf_alive() then
            open_split()
          end
        end,
      }

      require("opencode.config").provider = provider
      require("opencode.config").opts.provider = provider

      -- OpenCode keymaps
      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask OpenCode" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "OpenCode select action" })
      vim.keymap.set({ "n", "t" }, "<leader>oo", function() require("opencode").toggle() end, { desc = "Toggle OpenCode" })
      vim.keymap.set({ "n", "x" }, "<leader>or", function() require("opencode").prompt("review") end, { desc = "OpenCode review" })
      vim.keymap.set({ "n", "x" }, "<leader>oe", function() require("opencode").prompt("explain") end, { desc = "OpenCode explain" })
      vim.keymap.set({ "n", "x" }, "<leader>of", function() require("opencode").prompt("fix") end, { desc = "OpenCode fix" })
      vim.keymap.set({ "n", "x" }, "<leader>ot", function() require("opencode").prompt("test") end, { desc = "OpenCode test" })
    '';

    # ── Extra packages (formatters/linters not in nixpkgs LSP) ─────
    extraPackages = with pkgs; [
      nixfmt-rfc-style
      stylua
      prettierd
      shellcheck
      shfmt
      nodePackages.prettier
      helm-ls
      sqls
    ];
  };
}
