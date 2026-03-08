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
    jdk21
    just
    lldb # LLVM debugger
    maven
    ninja
    python313
    python313Packages.virtualenv
    rustup
    universal-ctags
    bear # compile_commands.json generator
    xxd
    zig

    # cli tools
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
    nitch
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
    dbeaver-bin # naoa
    # discord # not available on aarch64
    ghostty
    gimp
    # google-chrome
    home-manager
    jetbrains.idea
    kicad
    # mysql-workbench
    obs-studio
    rpi-imager
    scenebuilder
    # slack
    thunderbird
    vlc
    wl-clipboard
    rofi
    conky

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
    # powershell
    # remmina

    # exoticness
    # (pkgs.callPackage ./pkgs/visual-paradigm.nix { })
    # (pkgs.callPackage ./pkgs/packet-tracer.nix { })

    # 3d printing
    # (pkgs.callPackage ./pkgs/bambu-studio-appimage.nix { })
    # openscad-unstable

    # user
    nerd-fonts.jetbrains-mono

  ];
}
