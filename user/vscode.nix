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
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # ── Nix ──
      bbenoist.nix

      # ── Git ──
      eamodio.gitlens
      mhutchie.git-graph
      waderyan.gitblame

      # ── AI ──
      github.copilot
      github.copilot-chat

      # ── Languages ──
      golang.go
      rust-lang.rust-analyzer
      ziglang.vscode-zig
      twxs.cmake
      redhat.java
      redhat.vscode-yaml
      yzhang.markdown-all-in-one

      # ── Python ──
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance

      # ── Java ──
      vscjava.vscode-java-pack
      vscjava.vscode-java-debug
      vscjava.vscode-java-dependency
      vscjava.vscode-java-test
      vscjava.vscode-maven
      vscjava.vscode-gradle

      # ── C/C++ & Infra ──
      ms-vscode.cpptools
      ms-vscode.makefile-tools
      hashicorp.terraform

      # ── Containers ──
      ms-azuretools.vscode-docker
      ms-azuretools.vscode-containers
    ] ++ [
      # ── Marketplace-only extensions ──
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "prettify-json";
        publisher = "mohsen1";
        version = "0.0.3";
        sha256 = "1spj01dpfggfchwly3iyfm2ak618q2wqd90qx5ndvkj3a7x6rxwn";
      })
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "vscode-postgres";
        publisher = "ckolkman";
        version = "1.4.3";
        sha256 = "054a34icj8xig47w6k3j42i99b6srf254s5cl2knrgprrlsvcb1q";
      })
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "arm";
        publisher = "dan-c-underwood";
        version = "1.7.4";
        sha256 = "1xs5sfppdl7dkh4lyqsipfwax85jpn95rivpqas3z800rpvlr441";
      })
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "vscode-python-envs";
        publisher = "ms-python";
        version = "1.20.1";
        sha256 = "0ch3g8b1q67m98j5v9jwnpbwh1207q38wc0mk37kd7dpi9b2nplw";
      })
    ];
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
