{
  config,
  lib,
  ...
}:
{
  # catppuccin.starship.enable = config.programs.starship.enable;

  programs = {
    starship = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;
      # https://github.com/etrigan63/Catppuccin-starship
      settings = {
        add_newline = false;
        command_timeout = 1000;
        time = {
          disabled = true;
        };

        palette = "catppuccin_mocha";
      
        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };

        format = lib.concatStrings [
          "[█](surface1)"
          "$os"
          "[](bg:surface2 fg:surface1)"
          "$username"
          "$sudo"
          "[](bg:overlay0 fg:surface2)"
          "$hostname"
          "[](bg:mauve fg:overlay0)"
          "$directory"
          "[](fg:mauve bg:peach)"
          "$c"
          "$dart"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$golang"
          "$haskell"
          "$haxe"
          "$java"
          "$julia"
          "$kotlin"
          "$lua"
          "$nim"
          "$nodejs"
          "$rlang"
          "$ruby"
          "$rust"
          "$perl"
          "$php"
          "$python"
          "$scala"
          "$swift"
          "$zig"
          "$package"
          "$git_branch"
          "[](fg:peach bg:yellow)"
          "$git_status"
          "[](fg:yellow bg:teal)"
          "$container"
          "$direnv"
          "$nix_shell"
          "$cmd_duration"
          "$jobs"
          "$shlvl"
          "$status"
          "\n"
          "$character"
        ];
        os = {
          disabled = false;
          format = "$symbol";
          style = "";
        };
        os.symbols = {
          AlmaLinux = "[](fg:text bg:surface1)";
          Alpine = "[](fg:blue bg:surface1)";
          Amazon = "[](fg:peach bg:surface1)";
          Android = "[](fg:green bg:surface1)";
          Arch = "[󰣇](fg:sapphire bg:surface1)";
          Artix = "[](fg:sapphire bg:surface1)";
          CentOS = "[](fg:mauve bg:surface1)";
          Debian = "[](fg:red bg:surface1)";
          DragonFly = "[](fg:teal bg:surface1)";
          EndeavourOS = "[](fg:mauve bg:surface1)";
          Fedora = "[](fg:blue bg:surface1)";
          FreeBSD = "[](fg:red bg:surface1)";
          Garuda = "[](fg:sapphire bg:surface1)";
          Gentoo = "[](fg:lavender bg:surface1)";
          Illumos = "[](fg:peach bg:surface1)";
          Kali = "[](fg:blue bg:surface1)";
          Linux = "[](fg:yellow bg:surface1)";
          Macos = "[](fg:text bg:surface1)";
          Manjaro = "[](fg:green bg:surface1)";
          Mariner = "[](fg:sky bg:surface1)";
          MidnightBSD = "[](fg:yellow bg:surface1)";
          Mint = "[󰣭](fg:teal bg:surface1)";
          NetBSD = "[](fg:peach bg:surface1)";
          NixOS = "[](fg:sky bg:surface1)";
          OpenBSD = "[](fg:yellow bg:surface1)";
          openSUSE = "[](fg:green bg:surface1)";
          OracleLinux = "[󰌷](fg:red bg:surface1)";
          Pop = "[](fg:sapphire bg:surface1)";
          Raspbian = "[](fg:maroon bg:surface1)";
          Redhat = "[](fg:red bg:surface1)";
          RedHatEnterprise = "[](fg:red bg:surface1)";
          RockyLinux = "[](fg:green bg:surface1)";
          Solus = "[](fg:blue bg:surface1)";
          SUSE = "[](fg:green bg:surface1)";
          Ubuntu = "[](fg:peach bg:surface1)";
          Unknown = "[](fg:text bg:surface1)";
          Void = "[](fg:green bg:surface1)";
          Windows = "[󰖳](fg:sky bg:surface1)";
        };
        username = {
          aliases = {
            "${config.home.username}" = "󰝴";
            "root" = "󰱯";
          };
          format = "[ $user]($style)";
          show_always = true;
          style_user = "fg:green bg:surface2";
          style_root = "fg:red bg:surface2";
        };
        sudo = {
          disabled = false;
          format = "[ $symbol]($style)";
          style = "fg:rosewater bg:surface2";
          symbol = "󰌋";
        };
        hostname = {
          disabled = false;
          style = "bg:overlay0 fg:red";
          ssh_only = false;
          ssh_symbol = " 󰖈";
          format = "[ $hostname]($style)[$ssh_symbol](bg:overlay0 fg:maroon)";
        };
        directory = {
          format = "[ $path]($style)[$read_only]($read_only_style)";
          home_symbol = "";
          read_only = " 󰈈";
          read_only_style = "bold fg:crust bg:mauve";
          style = "fg:base bg:mauve";
          truncation_length = 100;
          truncate_to_repo = false;
          truncation_symbol = "…/";
        };
        # Shorten long paths by text replacement. Order matters
        directory.substitutions = {
          "Apps" = "󰵆";
          "Audio" = "";
          "Crypt" = "󰌾";
          "Desktop" = "";
          "Development" = "";
          "Documents" = "󰈙";
          "Downloads" = "󰉍";
          "Dropbox" = "";
          "Games" = "󰊴";
          "Keybase" = "󰯄";
          "Music" = "󰎄";
          "Pictures" = "";
          "Public" = "";
          "Quickemu" = "";
          "Studio" = "󰡇";
          "Vaults" = "󰌿";
          "Videos" = "";
          "Volatile" = "󱪃";
          "Websites" = "󰖟";
          "nix-config" = "󱄅";
          "Zero" = "󰎡";
        };
        # Languages
        c = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        dart = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        dotnet = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        elixir = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        elm = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        erlang = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        golang = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        haskell = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "󰲒";
        };
        haxe = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        java = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "󰬷";
        };
        julia = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        kotlin = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        lua = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        nim = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        nodejs = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        perl = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        php = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "󰌟";
        };
        python = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        rlang = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        ruby = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        rust = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        scala = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        swift = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        zig = {
          format = "[ $symbol]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        package = {
          format = "[ $version]($style)";
          style = "fg:base bg:peach";
          version_format = "$raw";
        };
        git_branch = {
          format = "[ $symbol $branch]($style)";
          style = "fg:base bg:peach";
          symbol = "";
        };
        git_status = {
          format = "[ $all_status$ahead_behind]($style)";
          conflicted = "󰳤 ";
          untracked = " ";
          stashed = " ";
          modified = " ";
          staged = " ";
          renamed = " ";
          deleted = " ";
          typechanged = " ";
          # $ahead_behind is just one of these
          ahead = "󰜹";
          behind = "󰜰";
          diverged = "";
          up_to_date = "󰤓";
          style = "fg:base bg:yellow";
        };
        # "Shells"
        container = {
          format = "[ $symbol $name]($style)";
          style = "fg:base bg:teal";
          symbol = "󱋩";
        };
        direnv = {
          disabled = false;
          format = "[ $loaded]($style)";
          allowed_msg = "";
          not_allowed_msg = "";
          denied_msg = "";
          loaded_msg = "󰐍";
          unloaded_msg = "󰙧";
          style = "fg:base bg:teal";
          symbol = "";
        };
        nix_shell = {
          format = "[ $symbol $state( \\($name\\))]($style)";
          style = "bold fg:base bg:teal";
          symbol = "󱄅";
          impure_msg = "impure";
          pure_msg = "pure";
        };
        cmd_duration = {
          format = "[  $duration]($style)";
          min_time = 2500;
          min_time_to_notify = 60000;
          show_notifications = false;
          style = "fg:base bg:teal";
        };
        jobs = {
          format = "[ $symbol $number]($style)";
          style = "fg:base bg:teal";
          symbol = "󰣖";
        };
        shlvl = {
          disabled = false;
          format = "[ $symbol]($style)";
          repeat = false;
          style = "fg:surface1 bg:teal";
          symbol = "󱆃";
          threshold = 3;
        };
        status = {
          disabled = false;
          format = "$symbol";
          map_symbol = true;
          pipestatus = false;
          style = "";
          symbol = "[](fg:teal bg:pink)[  $status](fg:red bg:pink)[](fg:pink)";
          success_symbol = "[](fg:teal)";
          not_executable_symbol = "[](fg:teal bg:pink)[  $common_meaning](fg:red bg:pink)[](fg:pink)";
          not_found_symbol = "[](fg:teal bg:pink)[ 󰩌 $common_meaning](fg:red bg:pink)[](fg:pink)";
          sigint_symbol = "[](fg:teal bg:pink)[  $signal_name](fg:red bg:pink)[](fg:pink)";
          signal_symbol = "[](fg:teal bg:pink)[ ⚡ $signal_name](fg:red bg:pink)[](fg:pink)";
        };
        character = {
          disabled = false;
          format = "$symbol";
          error_symbol = "[╰─](fg:overlay0)[❯](bold red) ";
          success_symbol = "[╰─](fg:overlay0)[❯](bold green) ";
        };
      };
    };
  };
}
