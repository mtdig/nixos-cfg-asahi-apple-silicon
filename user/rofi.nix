{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    theme = "theme";
    extraConfig = {
      modi = "drun,run,ssh";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = " Apps";
      display-run = " Run";
      display-ssh = " SSH";
      drun-display-format = "{name}";
      font = "JetBrainsMono Nerd Font 12";
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
    };
  };

  home.file.".config/rofi/theme.rasi".text = ''
    * {
        nix-blue:       #7ebae4;
        nix-blue-dim:   #5277c3;
        nix-cyan:       #6fc2cf;
        bg:             #1a1b26e6;
        bg-alt:         #1e1f2be6;
        bg-selected:    #2a2b3de6;
        fg:             #c0caf5;
        fg-dim:         #6c7086;
        border-col:     #7ebae420;
        accent:         #7ebae4;
        urgent:         #f7768e;
        transparent:    #00000000;

        font: "JetBrainsMono Nerd Font 11";
        border: 0;
        margin: 0;
        padding: 0;
        spacing: 0;
    }

    window {
        width: 520px;
        background-color: @bg;
        border: 1px;
        border-color: @border-col;
        border-radius: 12px;
        transparency: "real";
        location: center;
        anchor: center;
    }

    mainbox {
        background-color: @transparent;
        children: [ inputbar, message, listview ];
    }

    inputbar {
        background-color: @bg-alt;
        border-radius: 12px 12px 0 0;
        padding: 14px 16px;
        spacing: 10px;
        children: [ prompt, entry ];
    }

    prompt {
        background-color: @transparent;
        text-color: @nix-blue;
        font: "JetBrainsMono Nerd Font Bold 12";
    }

    entry {
        background-color: @transparent;
        text-color: @fg;
        placeholder: "Search...";
        placeholder-color: @fg-dim;
    }

    message {
        background-color: @bg-alt;
        border-color: @border-col;
        padding: 8px 16px;
    }

    textbox {
        background-color: @transparent;
        text-color: @fg-dim;
    }

    listview {
        background-color: @transparent;
        columns: 1;
        lines: 8;
        padding: 8px 0;
        fixed-height: false;
        dynamic: true;
    }

    element {
        background-color: @transparent;
        padding: 8px 16px;
        spacing: 10px;
    }

    element normal.normal {
        background-color: @transparent;
        text-color: @fg;
    }

    element alternate.normal {
        background-color: @transparent;
        text-color: @fg;
    }

    element selected.normal {
        background-color: @bg-selected;
        text-color: @nix-blue;
        border-radius: 6px;
    }

    element selected.urgent {
        background-color: @urgent;
        text-color: @bg;
        border-radius: 6px;
    }

    element-icon {
        background-color: @transparent;
        size: 22px;
        vertical-align: 0.5;
    }

    element-text {
        background-color: @transparent;
        text-color: inherit;
        vertical-align: 0.5;
    }
  '';
}
