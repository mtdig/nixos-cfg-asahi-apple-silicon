{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--enable-features=WaylandWindowDecorations"
        "--enable-wayland-ime"
      ];
    };
    profiles.default.userSettings = {
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "github.copilot.nextEditSuggestions.enabled" = true;
      "gitlens.ai.model" = "vscode";
      "gitlens.ai.vscode.model" = "copilot:gpt-4.1";
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Noto Color Emoji', monospace";
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
      "zig.zls.enabled"= "on";
    };
  };
}
