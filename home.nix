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
  ];

  home.username = "jeroen";
  home.homeDirectory = "/home/jeroen";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    VBOX_PROGRAM_PATH = "/run/wrappers/bin";
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      fastfetch
      if ! command -v rustc &>/dev/null; then
        echo -e "\e[1;31m⚠ Rust is not installed! Run: rustup toolchain install stable\e[0m"
      fi
      shopt -s histappend
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      PROMPT_COMMAND="history -a; history -n; ''${PROMPT_COMMAND}"
      export PATH="/home/jeroen/local/bin:$PATH";
      nx() {
        nix-shell -p "$1" --run "''${2:-$1}"
      }

    '';
    shellAliases = {
      hconf = "nvim /home/jeroen/.config/home-manager/home.nix";
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

    };
  };

}
