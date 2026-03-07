{ appimageTools, fetchurl, lib, cacert, glib, glib-networking, webkitgtk_4_1,
  gst_all_1 }:

appimageTools.wrapType2 rec {
  pname = "bambu-studio";
  version = "02.05.00.66";

  src = fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v02.05.00.67/Bambu_Studio_ubuntu-24.04_PR-9540.AppImage";
    hash = "sha256-3ubZblrsOJzz1p34QiiwiagKaB7nI8xDeadFWHBkWfg=";
  };

  profile = ''
    export SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt"
    export GIO_MODULE_DIR="${glib-networking}/lib/gio/modules/"
  '';

  extraPkgs = pkgs: with pkgs; [
    cacert
    curl
    glib
    glib-networking
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    webkitgtk_4_1
  ];

  meta = {
    description = "PC Software for BambuLab's 3D printers";
    homepage = "https://github.com/bambulab/BambuStudio";
    license = lib.licenses.agpl3Plus;
    mainProgram = "bambu-studio";
    platforms = [ "x86_64-linux" ];
  };
}
