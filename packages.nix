{ pkgs, pkgs-duckdb-144, ... }:

{
  environment.systemPackages = with pkgs; [
    # dev
    clang
    clang-tools # clangd, clang-format, clang-tidy
    pkgsCross.musl64.stdenv.cc
    cmake
    cmake-format
    file
    gcc
    gnumake
    go
    (symlinkJoin {
      name = "godot";
      paths = [ godot ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/godot4 \
          --add-flags "--display-driver wayland"

        # Fix .desktop file to use wrapped binary
        for f in $out/share/applications/*.desktop; do
          cp --remove-destination "$(readlink -f "$f")" "$f"
          substituteInPlace "$f" \
            --replace-fail "${godot}/bin/" "$out/bin/"
        done
      '';
    })
    gparted
    jdk21
    just
    lldb # LLVM debugger
    maven
    ninja
    python313
    python313Packages.virtualenv
    opencode
    rustup
    universal-ctags
    #bear # compile_commands.json generator
    rsync
    xxd
    zig

    # cli tools
    azure-cli
    bat
    curl
    pandoc
    fastfetch
    fzf
    gh
    git
    git-cliff
    gitui
    glow
    jq
    navi
    ncdu
    openssl
    parted
    psmisc
    #nitch
    rage
    ripgrep
    ruff
    starship
    tree
    unzip
    uv
    wget
    wp-cli
    xq
    zip

    # productivity
    thunderbird
    pkgs-duckdb-144.duckdb
    dbeaver-bin # naoa
    ghostty
    gimp
    # google-chrome
    home-manager
    (jetbrains.idea.override {
      vmopts = "-Dawt.toolkit.name=WLToolkit";
    })
    kicad
    kdePackages.krdc
    libreoffice
    # mysql-workbench
    obs-studio
    #rpi-imager
    scenebuilder
    vlc
    wl-clipboard
    rofi
    conky
    pgadmin4

    # hyprland ecosystem
    ironbar # status bar (hyprland/mangowc)
    waybar # status bar (fallback)
    mangowc # wayland compositor
    dunst # notifications
    hyprpaper # wallpaper
    waypaper
    hyprlock # screen lock
    hypridle # idle management
    hyprshot # screenshot tool
    wlogout # logout menu
    swappy # screenshot editor
    grim # screenshot backend
    slurp # region selection
    cliphist # clipboard manager
    brightnessctl # brightness control
    playerctl # media controls
    pavucontrol # audio GUI
    blueman # bluetooth GUI
    networkmanagerapplet # network tray
    kdePackages.polkit-kde-agent-1 # auth popups
    libnotify # notify-send
    nwg-look # GTK theme settings
    nwg-displays # monitor/display settings GUI
    wlr-randr # wlroots output management (MangoWC scaling)
    papirus-icon-theme # icon theme for ironbar/rofi
    xdg-utils
    xdg-desktop-portal-hyprland

    # perf
    btop
    gdb
    gf
    heaptrack
    linuxPackages.perf
    valgrind
    glances
    htop
    stress-ng

    # hw / sys
    lsof
    pciutils
    procps
    rsync
    usbutils
    util-linux

    # network
    dig
    inetutils
    iproute2
    nettools
    nmap
    tcpdump

    # gns3
    gns3-server
    gns3-gui
    qemu

    # cloud
    ansible
    awscli2
    azure-cli # az
    google-cloud-sdk # gcloud
    ibmcloud-cli
    kubectl
    kubelogin # azure aks authentication
    kubectx # kubectx / kubens
    k9s # kubernetes TUI
    terraform
    terragrunt # terraform wrapper

    # virtualisation
    # spice-gtk
    virt-viewer
    # virtio-win

    # win
    # freerdp
    powershell
    remmina

    # exoticness
    # (pkgs.callPackage ./pkgs/visual-paradigm.nix { })
    # (pkgs.callPackage ./pkgs/packet-tracer.nix { })

    # 3d printing
    # (pkgs.callPackage ./pkgs/bambu-studio-appimage.nix { })
    (openscad-unstable.overrideAttrs { doCheck = false; })

    # user
    nerd-fonts.jetbrains-mono

    # gaming
    luanti-client

  ];
}
