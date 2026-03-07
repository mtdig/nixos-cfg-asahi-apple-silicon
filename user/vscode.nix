{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.userSettings = {
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "github.copilot.nextEditSuggestions.enabled" = true;
      "gitlens.ai.model" = "vscode";
      "gitlens.ai.vscode.model" = "copilot:gpt-4.1";
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
    };
  };
}
