{
  fetchzip,
  lib,
  nerd-fonts,
}:
nerd-fonts.inconsolata.overrideAttrs (old: rec {
  pname = "Inconsolata";
  version = "v3.000";

  src = fetchzip {
    url = "https://github.com/googlefonts/${pname}/releases/download/${version}/fonts_ttf.zip";
    sha256 = "sha256-GD+LKt/DhaVHyFmnax9bIZ2N26aWWm4VZxqee5L4Lvs=";
  };

  installPhase =
    /*
    bash
    */
    ''
      mkdir --parents $out/share/fonts/truetype/Inconsolata
      cp source/ttf/*.ttf $out/share/fonts/truetype/Inconsolata/
    '';

  meta = with lib; {
    description = "Development repo of Inconsolata Fonts by Raph Levien";
    homepage = "https://github.com/googlefonts/${pname}";
    license = licenses.ofl;
  };
})
