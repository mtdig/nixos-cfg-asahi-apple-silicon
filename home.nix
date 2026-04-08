{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./user/starship.nix
    ./user/nixvim.nix
    ./user/git.nix
    ./user/ghostty.nix
    ./user/vscode.nix
    ./user/kde-shortcuts.nix
    ./user/conky.nix
    ./user/rofi.nix
    ./user/hyprland.nix
    ./user/waybar.nix
    ./user/ironbar.nix
    ./user/mangowc.nix
    ./user/rbw.nix
  ];

  home.username = "jeroen";
  home.homeDirectory = "/home/jeroen";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "${pkgs.pkgsCross.musl64.stdenv.cc}/bin"
  ];

  home.sessionVariables = {
    VBOX_PROGRAM_PATH = "/run/wrappers/bin";
  };

  # ── IdeaVim — mirror Neovim keybinds in IntelliJ ──
  home.file.".ideavimrc".text = ''
    " ── IdeaVim config (synced with Neovim keybinds) ──
    let mapleader=" "

    " ── Plugins ──
    set surround
    set commentary
    set highlightedyank
    set nerdtree
    set which-key
    set notimeout

    " ── Settings ──
    set scrolloff=8
    set number
    set relativenumber
    set incsearch
    set ignorecase
    set smartcase
    set clipboard+=unnamed

    " ── Move selected lines in visual mode ──
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

    " ── Join lines without moving cursor ──
    nnoremap J mzJ`z

    " ── Centered scrolling ──
    nnoremap <C-d> <C-d>zz
    nnoremap <C-u> <C-u>zz

    " ── Centered search ──
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " ── Paste over selection without yanking ──
    xnoremap <leader>p "_dP

    " ── Yank to system clipboard ──
    nnoremap <leader>y "+y
    vnoremap <leader>y "+y
    nnoremap <leader>Y "+Y

    " ── Delete to void register ──
    nnoremap <leader>d "_d
    vnoremap <leader>d "_d

    " ── Escape from insert with Ctrl-C ──
    inoremap <C-c> <Esc>

    " ── Disable Q ──
    nnoremap Q <nop>

    " ── Window navigation ──
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " ── Toggle word wrap ──
    nnoremap <leader>w :action EditorToggleUseSoftWraps<CR>

    " ── Project view (netrw equivalent) ──
    nnoremap <leader>pv :NERDTreeToggle<CR>

    " ── File finder (telescope equivalent) ──
    nnoremap <leader>pf :action GotoFile<CR>
    nnoremap <leader>ps :action FindInPath<CR>

    " ── Harpoon-like bookmarks ──
    nnoremap <leader>hm :action ToggleBookmarkWithMnemonic<CR>
    nnoremap <leader>h1 :action GotoBookmark1<CR>
    nnoremap <leader>h2 :action GotoBookmark2<CR>
    nnoremap <leader>h3 :action GotoBookmark3<CR>
    nnoremap <leader>h4 :action GotoBookmark4<CR>
    nnoremap <leader>hn :action GotoNextBookmark<CR>
    nnoremap <leader>hp :action GotoPreviousBookmark<CR>

    " ── LSP-like actions ──
    nnoremap gd :action GotoDeclaration<CR>
    nnoremap gr :action FindUsages<CR>
    nnoremap gi :action GotoImplementation<CR>
    nnoremap K :action QuickJavaDoc<CR>
    nnoremap <leader>ca :action ShowIntentionActions<CR>
    nnoremap <leader>rn :action RenameElement<CR>
    nnoremap <leader>f :action ReformatCode<CR>
    nnoremap [d :action GotoNextError<CR>
    nnoremap ]d :action GotoPreviousError<CR>

    " ── Git ──
    nnoremap <leader>gb :action Annotate<CR>

    " ── Run/Debug ──
    nnoremap <leader>rr :action Run<CR>
    nnoremap <leader>rd :action Debug<CR>
    nnoremap <leader>rs :action Stop<CR>
  '';

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "breeze_cursors";
      size = 24;
    };
    font = {
      name = "Noto Sans";
      size = 10;
    };
    gtk2.extraConfig = ''
      gtk-enable-animations=1
      gtk-primary-button-warps-slider=1
      gtk-toolbar-style=3
      gtk-menu-images=1
      gtk-button-images=1
      gtk-cursor-blink-time=1000
      gtk-cursor-blink=1
      gtk-sound-theme-name="ocean"
    '';
  };

  nixpkgs.config.allowUnfree = true;

  dconf.settings = {
    "org/blueman/general" = {
      plugin-list = [ "!ConnectionNotifier" ];
    };
  };

  programs.bash = {
    enable = true;

    initExtra = ''
      # fastfetch
      if ! command -v rustc &>/dev/null; then
        echo -e "\e[1;31m⚠ Rust is not installed! Run: rustup toolchain install stable\e[0m"
      fi
      shopt -s histappend
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      PROMPT_COMMAND="history -a; history -n; ''${PROMPT_COMMAND}"
      export PATH="$HOME/local/bin:$PATH";
      nx() {
        nix-shell -p "$1" --run "''${2:-$1}"
      }

      get_maven_versions() {
        local coord="''${1:?Usage: get_maven_versions <group:artifact> [version_prefix] [classifier_filter]}"
        local version_prefix="''${2:-}"
        local classifier="''${3:-}"

        local group="''${coord%%:*}"
        local artifact="''${coord##*:}"
        local path="''${group//.//}/''${artifact}"
        local base_url="https://repo1.maven.org/maven2/''${path}"

        curl -s "''${base_url}/" \
          | grep -oP "href=\"\K''${version_prefix}[0-9.][^/\"]*" \
          | while read -r v; do
              if [[ -n "''$classifier" ]]; then
                curl -sf "''${base_url}/''${v}/" | grep -q "''$classifier" && echo "''$v"
              else
                echo "''$v"
              fi
            done
      }

      # Create a new KVM VM (arm64, VNC, UEFI) — works on Wayland
      # Usage: newvm <name> <disk-size-GB> <iso-path> [memory-MB] [vcpus] [os-variant]
      newvm() {
        local name="$1" disk="''${2:-20}" iso="$3"
        local mem="''${4:-2048}" cpus="''${5:-2}" os="''${6:-generic}"
        if [ -z "$name" ] || [ -z "$iso" ]; then
          echo "Usage: newvm <name> <disk-GB> <iso-path> [mem-MB] [vcpus] [os-variant]"
          echo "  e.g: newvm debian13 20 ~/Downloads/debian-13-arm64.iso 4096 4 debian12"
          echo "Find os-variant: virt-install --osinfo list | grep <os>"
          return 1
        fi
        sudo virt-install \
          --name "$name" \
          --memory "$mem" \
          --vcpus "$cpus" \
          --cpu host-passthrough \
          --os-variant "$os" \
          --disk "size=$disk,bus=virtio,format=qcow2" \
          --cdrom "$iso" \
          --network network=default \
          --graphics vnc,listen=127.0.0.1 \
          --video vga \
          --boot uefi \
          --noautoconsole && \
        echo "VM '$name' created! Connect with: vmview $name"
      }

    '';
    shellAliases = {
      hconf = "nvim $HOME/.config/home-manager/home.nix";
      gconf = "sudo -E nvim /etc/nixos/configuration.nix";
      gpac = "sudo -E nvim /etc/nixos/packages.nix";
      hswitch = "home-manager switch --flake /etc/nixos#\${USER}";
      gswitch = "sudo nixos-rebuild switch --flake /etc/nixos#\$(hostname)";
      sudo = "sudo -E ";
      vi = "nvim ";
      gnpch = "get-nix-pkg-commit-hash ";
      flake = "sudo -E nvim /etc/nixos/flake.nix";
      flup = "sudo nix flake update --flake /etc/nixos";
      nxs = "nix search nixpkgs ";
      flist = "nix-store -q --references /run/current-system/sw | sed 's/\\/nix\\/store\\/[a-z0-9]*-//' | sort";
      nxp = "nix-shell -p ";
      gp = "git push ";
      ga = "git add .";
      gc = "git commit -am ";
      md = "glow -w 120 -p ";
      vmctl = "virsh -c qemu:///system ";
      vmview = "virt-viewer --connect qemu:///system ";
      rcp = "rsync -rlvz --progress ";
      code = "code -n ";
      scale = "hyprctl keyword monitor eDP-1,2560x1600@60,0x0,";
      k = "kubectl ";
      v = "sudo virsh ";
      gmv = "get_maven_versions ";
    };
  };

}
