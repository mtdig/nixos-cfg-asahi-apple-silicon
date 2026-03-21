# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./apple-silicon-support
    ./packages.nix
    ./user/rust.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.kernelPatches = [
    {
      name = "remove-nova-core";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        NOVA_CORE = lib.mkForce lib.kernel.unset;
      };
    }
  ];

  fileSystems."/nix" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4";
  };
  #  fileSystems."/var/tmp" = {
  #    device = "/dev/nvme0n1p3";
  #    fsType = "ext4";
  #  };

  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
  nix.settings.extra-platforms = [ "x86_64-linux" ];
  boot.binfmt.registrations."x86_64-linux".fixBinary = true;
  # boot.binfmt.preferStaticEmulators = true;
  systemd.services.qemu-binfmt = {
    description = "Register QEMU binfmt handlers via tonistiigi/binfmt";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.docker}/bin/docker run --rm --privileged tonistiigi/binfmt --install amd64";
      RemainAfterExit = true;
    };
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.docker.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  #  services.xserver.xkb = {
  #    layout = "be";
  #    variant = "";
  #    model = "apple_iso";
  #    # model = "pc105";
  #  };

  services.xserver.xkb = {
    layout = "be-apple";
    model = "apple_iso";
    extraLayouts.be-apple = {
      description = "Belgian (Apple keyboard)";
      languages = [ "bel" ];
      symbolsFile = pkgs.writeText "be-apple" ''
        partial alphanumeric_keys
        xkb_symbols "basic" {
          include "be(basic)"
          name[Group1] = "Belgian (Apple)";
          key <TLDE> { [ at, numbersign, grave, asciitilde ] };
          key <AE05> { [ parenleft,  5,      braceleft,  bracketleft  ] };
          key <AE11> { [ parenright, degree, braceright, bracketright ] };
          key <AB06> { [ n, N, asciitilde, dead_tilde ] };
          key <BKSL> { [ grave, sterling, dead_grave, dead_breve ] };
        };
      '';
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # MangoWC — session entry for SDDM login screen
  services.displayManager.sessionPackages = [
    (pkgs.runCommand "mango-session"
      {
        passthru.providedSessions = [ "mango" ];
      }
      ''
              mkdir -p $out/share/wayland-sessions
              cat > $out/share/wayland-sessions/mango.desktop <<'EOF'
        [Desktop Entry]
        Encoding=UTF-8
        Name=Mango
        Comment=MangoWC tiling compositor
        Exec=mango -s ${config.users.users.jeroen.home}/.config/mango/autostart.sh
        Icon=mango
        Type=Application
        DesktopNames=mango
        EOF
      ''
    )
  ];

  networking.extraHosts = ''
    192.168.122.20 sel_site.local
    51.103.90.12 opdracht3.sel.edu
    10.100.0.200 portainer.k8s.local
    10.100.0.200 vaultwarden.k8s.local
  '';

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # Zram swap — compressed in-memory swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      # gutenprint # generic drivers for many printers
      # gutenprintBin # proprietary drivers for some Canon/Epson
      hplip # HP printers
    ];
  };

  # Printer/scanner discovery over the network (mDNS/Bonjour)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.asahi.peripheralFirmwareDirectory = "/boot/asahi";
  nix.settings.pure-eval = false;
  nix.settings.extra-sandbox-paths = [ "/boot" ];
  # nix.settings.build-dir = "/var/tmp";

  security.wrappers = {
    ubridge = {
      source = "${pkgs.ubridge}/bin/ubridge";
      capabilities = "cap_net_admin,cap_net_raw=ep";
      owner = "root";
      group = "root";
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # ESP-IDF requires python-ecdsa which is marked insecure
  nixpkgs.config.permittedInsecurePackages = [
    "python3.13-ecdsa-0.19.1"
  ];

  users.users.jeroen = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "docker"
      "libvirtd"
      "dialout"
    ];
    initialPassword = "changeme";
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  programs.firefox.enable = false;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    git
    vscode
    chromium
  ];

  nixpkgs.config.allowUnfree = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
