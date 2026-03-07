{ lib, stdenv, fetchurl, dpkg, patchelf, zlib, buildFHSEnv, writeScript
, alsa-lib, at-spi2-atk, at-spi2-core, atk, cairo, cups, dbus
, expat, fontconfig, freetype, gdk-pixbuf, glib, gtk3, libGL
, libdrm, libpng, libpulseaudio, libxkbcommon, libxml2, mesa
, nspr, nss, pango, xorg, xz, brotli, harfbuzz, libtiff, jbigkit
, libdeflate, openssl, libglvnd, systemd, ... }:

let
  ptFiles = stdenv.mkDerivation {
    pname = "packet-tracer-patched";
    version = "9.0.0";

    src = fetchurl {
      url = "https://breadandbytes.be/files/CiscoPacketTracer_900_Ubuntu_64bit.deb";
      sha256 = "sha256-3ZrA1Mf8N9y2j2J/18fm+m1CAMFEklJuVhi5vRcu2SA=";
    };

    nativeBuildInputs = [ dpkg patchelf zlib ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $TMPDIR/deb
      dpkg-deb -x $src $TMPDIR/deb
      chmod +x $TMPDIR/deb/opt/pt/packettracer.AppImage
      patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
        $TMPDIR/deb/opt/pt/packettracer.AppImage
      mkdir -p $out
      cd $out
      LD_LIBRARY_PATH=${zlib}/lib \
        $TMPDIR/deb/opt/pt/packettracer.AppImage --appimage-extract

      # Patch all ELF binaries in the extracted directory
      find $out -type f -executable | while read f; do
        if head -c 4 "$f" | grep -q $'\\x7fELF'; then
          patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} "$f" 2>/dev/null || true
        fi
      done

      # Patch platform plugins RPATH to find bundled Qt6 libs
      for p in $out/squashfs-root/opt/pt/bin/platforms/*.so; do
        patchelf --set-rpath '$ORIGIN/..' "$p" 2>/dev/null || true
      done
    '';
  };

in buildFHSEnv {
  name = "packet-tracer";

  targetPkgs = pkgs: with pkgs; [
    # Core system libs
    stdenv.cc.cc.lib
    zlib
    glib
    dbus
    expat

    # Graphics
    libGL
    libglvnd
    libdrm
    mesa

    # Fonts & text
    fontconfig
    freetype
    libpng
    harfbuzz
    brotli
    libtiff
    jbigkit
    libdeflate

    # Audio
    libpulseaudio
    alsa-lib

    # Input / misc
    libxkbcommon
    libxml2
    xz

    # Security
    nspr
    nss
    openssl

    # System
    systemd  # provides libudev.so.1

    # GTK / accessibility
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    pango
    gdk-pixbuf
    gtk3
    cups

    # Xorg
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libICE
    xorg.libSM

    # NOTE: Do NOT add qt5/qt6 here — Packet Tracer bundles its own
    # Qt 6.8.x and mixing with system Qt causes ABI crashes.
  ];

  runScript = writeScript "packet-tracer" ''
    #!${stdenv.shell}
    # Bundled Qt libs MUST come first to avoid conflicts with any system Qt.
    # /usr/lib provides the FHS-mapped system libraries from targetPkgs.
    export LD_LIBRARY_PATH=${ptFiles}/squashfs-root/opt/pt/bin:/usr/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
    # Use only the bundled Qt platform plugins (xcb + linuxfb)
    export QT_QPA_PLATFORM_PLUGIN_PATH=${ptFiles}/squashfs-root/opt/pt/bin/platforms
    # Force XCB — no Wayland platform plugin is bundled
    export QT_QPA_PLATFORM=xcb
    # Prevent Qt from searching system plugin paths
    export QT_PLUGIN_PATH=${ptFiles}/squashfs-root/opt/pt/bin
    exec ${ptFiles}/squashfs-root/opt/pt/bin/PacketTracer "$@"
  '';
}
