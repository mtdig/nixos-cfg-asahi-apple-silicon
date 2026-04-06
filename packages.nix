{ pkgs, pkgs-duckdb-144, ... }:

{
  environment.systemPackages = with pkgs; [
    audit # Linux audit framework for security auditing

    # ── Dev ──
    clang # C/C++/ObjC compiler (LLVM-based)
    clang-tools # clangd, clang-format, clang-tidy
    pkgsCross.musl64.stdenv.cc # Cross-compiler targeting x86_64 musl libc
    cmake # Cross-platform build system generator
    cmake-format # Formatter for CMakeLists.txt files
    file # File type identification utility
    gcc # GNU C/C++ compiler
    gnumake # GNU Make build automation tool
    go # Go programming language compiler & tools
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
    }) # Godot 4 game engine (wrapped for native Wayland)
    gparted # Graphical disk partition editor
    jdk21 # Java Development Kit 21
    just # Command runner (modern make alternative)
    lldb # LLVM debugger
    man-pages # Linux man pages
    maven # Java project build & dependency manager
    ninja # Small fast build system
    python313 # Python 3.13 interpreter
    python313Packages.virtualenv # Python virtual environment creator
    opencode # AI coding assistant CLI
    p7zip # 7-Zip file archiver (CLI)
    rustup # Rust toolchain installer & manager
    universal-ctags # Source code indexing (tags) for editors
    #bear # compile_commands.json generator
    rsync # Fast incremental file transfer
    xxd # Hex dump / reverse hex dump utility
    zig # Zig programming language compiler

    # ── CLI Tools ──
    azure-cli # Microsoft Azure CLI (az)
    bat # Cat clone with syntax highlighting
    curl # URL data transfer tool
    pandoc # Universal document format converter
    fastfetch # Fast system info fetcher (neofetch alternative)
    fzf # Fuzzy finder for terminal
    ffmpeg # duh
    gh # GitHub CLI
    git # Distributed version control
    git-cliff # Changelog generator from git history
    gitui # Terminal UI for git
    glow # Markdown renderer for the terminal
    jq # JSON processor for the command line
    navi # Interactive cheat sheet for CLI commands
    ncdu # Interactive disk usage analyzer
    openssl # Cryptography & SSL/TLS toolkit
    parted # CLI disk partition editor
    psmisc # Process utilities (killall, fuser, pstree)
    #nitch
    rage # Modern age-compatible file encryption
    ripgrep # Fast recursive grep (rg)
    ruff # Fast Python linter & formatter
    starship # Cross-shell prompt
    sshpass
    tree # Directory listing in tree format
    unzip # ZIP archive extractor
    uv # Fast Python package installer (pip alternative)
    wget # File downloader via HTTP/FTP
    wp-cli # WordPress command-line interface
    xq # XML/HTML processor (jq for XML)
    zathura # document viewer
    zip # ZIP archive creator

    # ── Productivity ──
    thunderbird # Email client (with Exchange/EWS support)
    pkgs-duckdb-144.duckdb # Analytical SQL database engine (CLI)
    dbeaver-bin # Universal database GUI client
    ghostty # GPU-accelerated terminal emulator
    gimp # Image editor (GNU Image Manipulation Program)
    # google-chrome
    home-manager # Nix-based user environment manager
    (
      let
        idea = jetbrains.idea.override { vmopts = "-Dawt.toolkit.name=WLToolkit"; };
      in
      symlinkJoin {
        name = "idea-ultimate";
        paths = [ idea ];
        buildInputs = [ makeWrapper ];
        postBuild = ''
          # Replace symlink with actual file so wrapProgram can wrap it
          cp --remove-destination "$(readlink -f "$out/bin/idea")" "$out/bin/idea"
          wrapProgram $out/bin/idea \
            --prefix LD_LIBRARY_PATH : "${
              pkgs.lib.makeLibraryPath (
                with pkgs;
                [
                  libGL
                  gtk3
                  glib
                  xorg.libXtst
                  xorg.libXxf86vm
                  cairo
                  pango
                  gdk-pixbuf
                  freetype
                  fontconfig
                ]
              )
            }"

          # Fix .desktop file to use wrapped binary
          rm -rf $out/share/applications
          mkdir -p $out/share/applications
          for f in ${idea}/share/applications/*.desktop; do
            sed "s|${idea}/bin/|$out/bin/|g" "$f" > "$out/share/applications/$(basename "$f")"
          done
        '';
      }
    ) # IntelliJ IDEA (with native Wayland toolkit + library paths)
    kicad # Electronics schematic & PCB design
    kdePackages.krdc # KDE remote desktop client (RDP/VNC)
    libreoffice # Office suite (docs, sheets, presentations)
    # mysql-workbench
    obs-studio # Screen recording & streaming
    #rpi-imager
    scenebuilder # JavaFX GUI designer for FXML
    (symlinkJoin {
      name = "vlc";
      paths = [ vlc ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vlc \
          --set QT_QPA_PLATFORM wayland

        # Fix .desktop file to use wrapped binary
        for f in $out/share/applications/*.desktop; do
          cp --remove-destination "$(readlink -f "$f")" "$f"
          substituteInPlace "$f" \
            --replace-fail "${vlc}/bin/" "$out/bin/"
        done
      '';
    }) # Media player (wrapped for native Wayland)
    wl-clipboard # Wayland clipboard utilities (wl-copy, wl-paste)
    rofi # Application launcher / dmenu replacement
    conky # Desktop system monitor widget
    pgadmin4 # PostgreSQL administration web GUI

    # ── Hyprland Ecosystem ──
    ironbar # Status bar (hyprland/mangowc)
    waybar # Status bar (fallback)
    mangowc # Wayland compositor
    dunst # Notification daemon
    hyprpaper # Wallpaper manager for Hyprland
    waypaper # GUI wallpaper picker for Wayland
    hyprlock # Screen lock for Hyprland
    hypridle # Idle management daemon for Hyprland
    hyprshot # Screenshot tool for Hyprland
    wlogout # Graphical logout menu
    swappy # Screenshot annotation editor
    grim # Screenshot backend (Wayland)
    slurp # Region selection tool (Wayland)
    wf-recorder # Screen recorder for Wayland (CLI)
    cliphist # Clipboard history manager
    brightnessctl # Backlight brightness control
    playerctl # MPRIS media player control
    pavucontrol # PulseAudio/PipeWire volume control GUI
    blueman # Bluetooth manager GUI
    networkmanagerapplet # NetworkManager system tray applet
    kdePackages.polkit-kde-agent-1 # Polkit authentication dialog
    libnotify # Desktop notification library (notify-send)
    nwg-look # GTK theme/appearance settings
    nwg-displays # Monitor/display configuration GUI
    wlr-randr # wlroots output management CLI (MangoWC scaling)
    papirus-icon-theme # Icon theme for ironbar/rofi
    xdg-utils # Desktop integration utilities (xdg-open, etc.)
    xdg-desktop-portal-hyprland # XDG portal backend for Hyprland

    # ── Performance & Debugging ──
    btop # Resource monitor TUI (htop alternative)
    gdb # GNU debugger
    gf # GDB frontend TUI
    heaptrack # Heap memory profiler
    linuxPackages.perf # Linux kernel performance analysis tool
    valgrind # Memory error detector & profiler
    glances # Cross-platform system monitoring tool
    htop # Interactive process viewer
    stress-ng # System stress testing tool

    # ── Hardware & System ──
    lsof # List open files
    pciutils # PCI utilities (lspci)
    procps # Process utilities (ps, top, free, vmstat)
    rsync # Fast incremental file transfer
    usbutils # USB utilities (lsusb)
    util-linux # Core system utilities (lsblk, fdisk, mount, etc.)

    # ── Network ──
    dig # DNS lookup utility
    inetutils # Basic networking tools (ping, ftp, telnet)
    iproute2 # Advanced networking tools (ip, ss, tc)
    nettools # Classic networking tools (ifconfig, netstat, route)
    nmap # Network scanner & security auditing
    tcpdump # Network packet analyzer

    # ── GNS3 ──
    gns3-server # GNS3 network simulator backend
    gns3-gui # GNS3 network simulator GUI
    qemu # Machine emulator & virtualizer

    # ── Cloud & Infrastructure ──
    ansible # IT automation & configuration management
    awscli2 # Amazon Web Services CLI v2
    azure-cli # Microsoft Azure CLI (az)
    google-cloud-sdk # Google Cloud CLI (gcloud)
    ibmcloud-cli # IBM Cloud CLI
    kubectl # Kubernetes cluster CLI
    kubelogin # Azure AKS authentication plugin
    kubectx # Kubernetes context/namespace switcher
    k9s # Kubernetes cluster TUI
    terraform # Infrastructure as Code provisioning
    terragrunt # Terraform wrapper for DRY configs

    # ── Virtualisation ──
    # spice-gtk
    virt-viewer # VM console viewer (VNC/SPICE)
    # virtio-win

    # ── Windows / Remote Desktop ──
    # freerdp
    powershell # Microsoft PowerShell (cross-platform)
    (symlinkJoin {
      name = "remmina";
      paths = [ remmina ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/remmina \
          --set GDK_BACKEND wayland

        # Fix .desktop file to use wrapped binary
        for f in $out/share/applications/*.desktop; do
          cp --remove-destination "$(readlink -f "$f")" "$f"
          substituteInPlace "$f" \
            --replace-fail "${remmina}/bin/" "$out/bin/"
        done
      '';
    }) # Remote desktop client (RDP, VNC, SSH, SPICE) (wrapped for native Wayland)

    # ── Exotic / Custom Packages ──
    # (pkgs.callPackage ./pkgs/visual-paradigm.nix { })
    # (pkgs.callPackage ./pkgs/packet-tracer.nix { })

    # ── 3D Printing ──
    # (pkgs.callPackage ./pkgs/bambu-studio-appimage.nix { })
    (openscad-unstable.overrideAttrs { doCheck = false; }) # Parametric 3D CAD modeler (scripted)

    # ── Fonts ──
    nerd-fonts.jetbrains-mono # JetBrains Mono with Nerd Font icons

    # ── Gaming ──
    luanti-client # Luanti (formerly Minetest) voxel game client

  ];
}
