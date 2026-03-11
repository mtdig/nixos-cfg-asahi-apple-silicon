{ pkgs, pkgs-duckdb-144, ... }:

{
  environment.systemPackages = with pkgs; [
    # dev
    clang
    clang-tools # clangd, clang-format, clang-tidy
    cmake
    cmake-format
    file
    gcc
    gnumake
    go
    godot
    gparted
    jdk21
    just
    lldb # LLVM debugger
    maven
    ninja
    python313
    python313Packages.virtualenv
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
    git
    git-cliff
    gitui
    glow
    jq
    navi
    ncdu
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
    pkgs-duckdb-144.duckdb
    #dbeaver-bin # naoa
    ghostty
    gimp
    # google-chrome
    home-manager
    jetbrains.idea
    kicad
    # mysql-workbench
    obs-studio
    #rpi-imager
    scenebuilder
    thunderbird
    vlc
    wl-clipboard
    rofi
    conky

    # hyprland ecosystem
    ironbar # status bar (hyprland/mangowc)
    waybar # status bar (fallback)
    mangowc # wayland compositor
    dunst # notifications
    hyprpaper # wallpaper
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

    # cloud
    ansible
    awscli2
    azure-cli # az
    google-cloud-sdk # gcloud
    helm
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

  ];
}
