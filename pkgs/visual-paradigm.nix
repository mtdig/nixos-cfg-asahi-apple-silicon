{ lib, stdenv, fetchurl, makeWrapper, autoPatchelfHook
, zlib, freetype, glib, pango
, gdk-pixbuf, gtk3, mesa, alsa-lib
, xorg, jdk21 }:

stdenv.mkDerivation rec {
  pname = "visual-paradigm";
  version = "17.3";

  src = fetchurl {
    url = "https://www.visual-paradigm.com/downloads/vp17.3/Visual_Paradigm_Linux64_InstallFree.tar.gz";
    sha256 = "sha256-IPmFVHuUKwPFe8GZiYlgOgNxpYvMGxapE06fbbj5ZLM=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  buildInputs = [
    zlib freetype glib pango
    gdk-pixbuf gtk3 mesa alsa-lib
    xorg.libXtst xorg.libXi
    jdk21
  ];

  autoPatchelfIgnoreMissingDeps = [ "*" ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out/

    # Replace bundled JRE with system JDK21
    rm -rf $out/jre
    ln -s ${jdk21} $out/jre
    
    makeWrapper $out/Application/bin/Visual_Paradigm $out/bin/visual-paradigm \
      --set INSTALL4J_JAVA_HOME ${jdk21} \
      --run 'mkdir -p "$HOME/.config/VisualParadigm/tmp"; export INSTALL4J_ADD_VM_PARAMS="-Djava.io.tmpdir=$HOME/.config/VisualParadigm/tmp"'

     # makeWrapper $out/Application/bin/Visual_Paradigm $out/bin/visual-paradigm \
     # --set INSTALL4J_JAVA_HOME ${jdk21}
  '';
}
